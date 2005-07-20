Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVGTInm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVGTInm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 04:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVGTInm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 04:43:42 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:52406 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261417AbVGTInl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 04:43:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=BtO9EUg55sp/7xAFpy4ujKdP/R7gYeG75C+hBGlHUxbaw42nIjVdrggewazV72CT4MZC9pVmv0xskl8o/BFVDZoaNzEHEtIK2B3+lcwPWoP3YHwvlBVC8QJxRTCz2ZA4biRzXnzEVa1fOZqM2mi3IczgFdYLhKPVZeszakHuawk=
Subject: Re: Noob question. Why is the for-pentium4 kernel built
	with	-march=i686 ?
From: Kerin Millar <kerframil@gmail.com>
To: ivan@yosifov.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1121847799.31603.5.camel@home.yosifov.net>
References: <1121792852.11857.6.camel@home.yosifov.net>
	 <Pine.LNX.4.61.0507191950020.89@yvahk01.tjqt.qr>
	 <1121798151.15700.9.camel@home.yosifov.net>
	 <pan.2005.07.20.08.03.25.15476@gmail.com>
	 <1121847799.31603.5.camel@home.yosifov.net>
Content-Type: text/plain
Date: Wed, 20 Jul 2005 10:44:02 +0100
Message-Id: <1121852642.18129.39.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-20 at 11:23 +0300, Ivan Yosifov wrote:
> On Wed, 2005-07-20 at 09:03 +0100, Kerin Millar wrote:
> > On Tue, 19 Jul 2005 21:35:51 +0300, Ivan Yosifov wrote:
> > 

<snip>

> > Also, I believe that the -march=pentium4 option /was/ actually used up
> > until kernel 2.6.10 where it was dropped because of a risk that some
> > versions of gcc would cause the kernel to use SSE registers for data
> > movement (which is a no-no).
> > 
> 
> You seem right. I fetched a 2.6.9 tarball and it is really built with
> -march=pentium4. Do you know which are versions of gcc in question ?
> 

No, I'm afraid not. I only know that the advice came from Richard
Henderson who (I think) is one of the core glibc hackers. You can see
the point at which it was introduced by Linus in the ChangeLog (2nd
message from last):

http://www.kernel.org/pub/linux/kernel/v2.6/ChangeLog-2.6.10

Cheers,

--Kerin Millar

