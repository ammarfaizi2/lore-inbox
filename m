Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268348AbUIJGdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268348AbUIJGdf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 02:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268286AbUIJGdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 02:33:33 -0400
Received: from smtp.e7even.com ([83.151.192.5]:25820 "HELO smtp.e7even.com")
	by vger.kernel.org with SMTP id S268316AbUIJGdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 02:33:31 -0400
Subject: Re: silent semantic changes with reiser4
From: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
To: Hans Reiser <reiser@namesys.com>
Cc: Timothy Miller <miller@techsource.com>, Jamie Lokier <jamie@shareable.org>,
       Adrian Bunk <bunk@fs.tum.de>, viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <41413A2B.9020405@namesys.com>
References: <20040825200859.GA16345@lst.de>
	 <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org>
	 <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org>
	 <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk>
	 <20040826001152.GB23423@mail.shareable.org>
	 <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk>
	 <20040826010049.GA24731@mail.shareable.org> <412DA40B.5040806@namesys.com>
	 <20040826140500.GA29965@fs.tum.de>
	 <20040826150202.GE5733@mail.shareable.org>
	 <41410DE7.3090100@techsource.com>  <41413A2B.9020405@namesys.com>
Content-Type: text/plain
Message-Id: <1094797973.4838.4.camel@almond.st-and.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 10 Sep 2004 07:32:54 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-10 at 06:22, Hans Reiser wrote:
> He asked me, why not just access a filename's size as filename/size?

I now understand that you need a way to distinguish between something
like

shoe/size

and

shoe/.../size   (or shoe/..size)

The first one is the size of the shoe, the second is the automatically
generated size of the file (object). You would get into trouble if you
would not allow the user to use shoe/size for shoe size. Peter


