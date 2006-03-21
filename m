Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbWCUC4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWCUC4J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 21:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWCUC4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 21:56:09 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:157 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751443AbWCUC4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 21:56:08 -0500
Message-ID: <9FCDBA58F226D911B202000BDBAD4673054C365C@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Lindent and coding style
Date: Tue, 21 Mar 2006 10:55:51 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Sent: Monday, March 20, 2006 10:37 PM
> To: Li Yang-r58472
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Lindent and coding style
> 
> On Llu, 2006-03-20 at 19:32 +0800, Li Yang-r58472 wrote:
> > There is a lindent script in linux kernel source.  It breaks long
> > lines, but uses space instead of tab as indentation.  However, the
> > codingstyle document also from the kernel source indicates no space is
> > allowed for indentation.  Is there a fix for this problem?  Or the
> > result from lindent(space indentation) is actually allowed in kernel
> > source?  Thanks.
> >
> 
> It should produce suitable output. Do you have examples of where it
> produces space indentation and you expect tabs ?
As Jiri has said, it produces code like
<tab>	if (very long condition &&
<tab>   ssss2nd condition)...
The indent command will align the second line at the next character of the left parentheses it belongs to.  In my opinion, this approach makes code more readable.  However, it does not comply with the coding style of kernel.
