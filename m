Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271718AbRICOZF>; Mon, 3 Sep 2001 10:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271719AbRICOY4>; Mon, 3 Sep 2001 10:24:56 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:2309 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271718AbRICOYo>; Mon, 3 Sep 2001 10:24:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser)
Subject: Re: Editing-in-place of a large file
Date: Mon, 3 Sep 2001 16:31:55 +0200
X-Mailer: KMail [version 1.3.1]
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        mcelrath+linux@draal.physics.wisc.edu (Bob McElrath)
In-Reply-To: <E15drHT-0001TX-00@the-village.bc.nu>
In-Reply-To: <E15drHT-0001TX-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010903142500Z16351-32383+3245@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 3, 2001 12:48 pm, Alan Cox wrote:
> > That is reimplementing file system functionality in user space. 
> > I'm in doubts that this is considered good design...
> 
> Keeping things out of the kernel is good design. Your block indirections
> are no different to other database formats. Perhaps you think we should
> have fsql_operation() and libdb in kernel 8)

For that matter, he could use a database file.  I don't know if Postgres (for 
example) supports streaming read/write from a database record, but if it 
doesn't it could be made to.

Or if he doesn't want to hack Postgres today, he can put his "metadata" in a 
database file and the video data in a separate file.

--
Daniel
