Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263820AbTIBVr5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 17:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263754AbTIBVr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 17:47:57 -0400
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:51091 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S263765AbTIBVpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 17:45:46 -0400
From: James Clark <jimwclark@ntlworld.com>
Reply-To: jimwclark@ntlworld.com
To: linux-kernel@vger.kernel.org
Subject: Re: Driver Model
Date: Tue, 2 Sep 2003 22:44:55 +0100
User-Agent: KMail/1.5
Cc: Patrick Mochel <mochel@osdl.org>
References: <Pine.LNX.4.44.0309021420570.5614-100000@cherise>
In-Reply-To: <Pine.LNX.4.44.0309021420570.5614-100000@cherise>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309022244.55500.jimwclark@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before I posted my original question I read Patrick's very helpful overview of 
the Driver Model (www.amc.com.au/lca/loopback/papers/ 
Patrick_Mochel/Patrick_Mochel.pdf). 

The reason I posed the question, as a newcomer to kernel development, moving 
from WIN32 DDK development (sorry!) to Linux is that I was very surprised by 
the module interface. 

Would a more rigid 'plugin' interface and the concequent move from mainly 
'source' modules to binary 'plugins' (still with source-code available for 
all to see) mean that (a) Kernel was smaller (2) Had to be 
released/recompiled less (4) Was EVEN more stable and (4) 'plugins' were more 
portable across releases and easier to install ?

I love Linux but this seems to be holding it back...

James



On Tuesday 02 Sep 2003 10:29 pm, Patrick Mochel wrote:
> > 1. Will the move to a more uniform driver model in 2.6 increase the
> > chances of a given binary driver working with a 2.6+ kernel.
>
> Not necessarily. A binary driver still needs to be compiled for a specific
> version of a kernel. And, if it's not already working, the new driver
> model definitely won't help. :)
>
> > 2. Will the new model reduce the use/need for kernel modules. Would this
> > be a good thing if functionality could be implemented in a driver instead
> > of a module.
>
> No, it will not reduce usage of modules. The driver model has nothing to
> do with whether something is compiled as a module or not.
>
> > 3. Will the practice of deliberately breaking some binary only 'tainted'
> > modules prevent take up of Linux. Isn't this taking things too far?
>
> This is a loaded question, but ultimately it's a vendor issue. Most people
> do and will use vendor kernels. What they do with their kernel interfaces
> and how well they support binary modules is their beef.
>
>
> 	Pat

