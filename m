Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269428AbTGJSOU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 14:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269522AbTGJSOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 14:14:19 -0400
Received: from mx11.sac.fedex.com ([199.81.193.118]:38411 "EHLO
	mx11.sac.fedex.com") by vger.kernel.org with ESMTP id S269428AbTGJSOP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 14:14:15 -0400
Date: Fri, 11 Jul 2003 02:27:11 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: jchua@silk.corp.fedex.com
To: James Bourne <jbourne@hardrock.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Chua <jeff89@silk.corp.fedex.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.22-pre4 ide module fix init_cmd640_vlb
In-Reply-To: <Pine.LNX.4.44.0307100749340.20705-200000@cafe.hardrock.org>
Message-ID: <Pine.LNX.4.42.0307110223070.4985-100000@silk.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 07/11/2003
 02:28:49 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 07/11/2003
 02:28:52 AM,
	Serialize complete at 07/11/2003 02:28:52 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jul 2003, James Bourne wrote:

> On 10 Jul 2003, Alan Cox wrote:
>
> > And stops it working for everyone else. The function does exist too. See
> > drivers/ide/pci/cmd640.c

Sorry. Missed this one.


> Here's a patch that does that exact thing, I haven't tested it though.
>

"make" doesn't seem to pick up ide/pci/cmd640.c when IDE is compiled as a
module.

	touch drivers/ide/pci/cmd640.c; make; make modules;
	*** it doesn't compile cmd640.c


Jeff





