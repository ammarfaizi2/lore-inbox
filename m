Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272456AbTHOXPg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 19:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272458AbTHOXPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 19:15:36 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:43783 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S272456AbTHOXPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 19:15:32 -0400
Date: Sat, 16 Aug 2003 00:15:31 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: mouse and keyboard by default if not embedded
In-Reply-To: <E19mVL7-000EMp-00.arvidjaar-mail-ru@f20.mail.ru>
Message-ID: <Pine.LNX.4.44.0308160013450.21319-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > kYes it is fine. That is a PS/2 aux emulator. It turns non PS/2 mice into 
> > PS/2 mice. Personally I rather have people use the /dev/input/eventX 
> > interface. That PS/2 hack will go away in the future. 
> 
> does XFree support event?

I don't know but patches have been floating around for a while for 
XFree86.
 
> also there dual boot 2.4/2.6 systems where you have single XFree config
> and single gpm config ... although these will have problems with
> non-imps2 mice anyway.

Once everything starts using the event api we will not need configs 
anymore when it comes to input devices ;-)


