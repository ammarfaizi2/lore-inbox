Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269039AbRG3Rh5>; Mon, 30 Jul 2001 13:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269037AbRG3Rhh>; Mon, 30 Jul 2001 13:37:37 -0400
Received: from weta.f00f.org ([203.167.249.89]:26502 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S269030AbRG3Rhe>;
	Mon, 30 Jul 2001 13:37:34 -0400
Date: Tue, 31 Jul 2001 05:38:13 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Lawrence Greenfield <leg+@andrew.cmu.edu>,
        "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Chris Mason <mason@suse.com>
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010731053813.A5961@weta.f00f.org>
In-Reply-To: <Pine.LNX.4.33L.0107301422120.5582-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0107301422120.5582-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 30, 2001 at 02:25:51PM -0300, Rik van Riel wrote:

    Note that this is very different from the "link() should be
    synchronous()" mantra we've been hearing over the last days.
    
    These fsync() semantics make lots of sense to me, I'm all
    for it.

And what if the file has hundreds or thousands of links? How do we
cleanly keep track of all those?



  --cw

