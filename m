Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265106AbTFCQv3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 12:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265113AbTFCQv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 12:51:29 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:45767 "EHLO gaston")
	by vger.kernel.org with ESMTP id S265106AbTFCQv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 12:51:28 -0400
Subject: Re: software suspend in 2.5.70-mm3.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: hugang <hugang@soulinfo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1054649308.9233.26.camel@dhcp22.swansea.linux.org.uk>
References: <20030603211156.726366e7.hugang@soulinfo.com>
	 <1054646566.9234.20.camel@dhcp22.swansea.linux.org.uk>
	 <20030603223511.155ea2cc.hugang@soulinfo.com>
	 <1054649308.9233.26.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054659866.20839.10.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 03 Jun 2003 19:04:26 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-03 at 16:08, Alan Cox wrote:
> On Maw, 2003-06-03 at 15:35, hugang wrote:
> > > The only way to make the suspend work properly is to queue the suspend
> > > sequence wit the other requests. Ben was doing some playing with this
> > > but I'm not sure what happened to it.
> > > 
> > Yes the above patch is not safe, When i'm run updatedb and suspsned, After resume will oops at kjournal. 
> > 
> > Here is another test on it, it can works with updatedb.
> 
> Still races. Ben's stuff is needed

I have it working with some fixes from what I sent earlier, I'll
repost that tonight or tomorrow, I need to extract that from
a half-broken tree ;)

Ben.

