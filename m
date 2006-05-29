Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWE2QqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWE2QqS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 12:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWE2QqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 12:46:18 -0400
Received: from pih-relay04.plus.net ([212.159.14.131]:10136 "EHLO
	pih-relay04.plus.net") by vger.kernel.org with ESMTP
	id S1751133AbWE2QqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 12:46:17 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Subject: Re: Asus K8N-VM Motherboard Ethernet Problem
Date: Mon, 29 May 2006 17:46:01 +0100
User-Agent: KMail/1.9.1
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
References: <44793100.50707@perkel.com> <200605281920.02609.s0348365@sms.ed.ac.uk> <20060529141447.GA18892@csclub.uwaterloo.ca>
In-Reply-To: <20060529141447.GA18892@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605291746.01736.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 May 2006 15:14, Lennart Sorensen wrote:
> On Sun, May 28, 2006 at 07:20:02PM +0100, Alistair John Strachan wrote:
> > Five minutes of research and I found this:
> >
> > http://www.asus.com.tw/products4.aspx?modelmenu=2&model=952&l1=3&l2=14&l3
> >=245
> >
> > It indicates that the board, although using an nForce 410 chipset, does
> > NOT use NVIDIA ethernet, but (quote) "Relatek RTL8201CL external PHY";
> > you're probably trying the wrong driver and this is the source of the
> > problem.
> >
> > This info could be wrong, but I thought it might help.
>
> The linux driver is for the MAC, which is in the chipset.  The PHY is
> external, and it doens't particularly matter which one it is in general.
> The driver almost never has to care.  I know I don't have to tell the
> pcnet32 driver that I am using a broadcom 5221 PHY with it.  It works
> just fine because the MAC is an AMD 972 which is one fo the chips the
> pcnet32 driver operates.

Since this document reveals no information about such a MAC device, it is 
still unknown whether forcedeth is truly to blame. From the silence of the 
original poster I'm inclined to assume he's fixed the problem..

I was suspicious because in contra to the original post, it is NOT the case 
that Windows XP (even SP2) will automatically detect and support NVIDIA 
ethernet; a third party driver must be installed before the device is usable. 
Realtek chips, however, tend to work out of the box..

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
