Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbTIBV0W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 17:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbTIBVXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 17:23:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:5041 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261324AbTIBVXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 17:23:21 -0400
Date: Tue, 2 Sep 2003 14:29:36 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: James Clark <jimwclark@ntlworld.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Driver Model
In-Reply-To: <200309021943.15875.jimwclark@ntlworld.com>
Message-ID: <Pine.LNX.4.44.0309021420570.5614-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 1. Will the move to a more uniform driver model in 2.6 increase the chances of 
> a given binary driver working with a 2.6+ kernel. 

Not necessarily. A binary driver still needs to be compiled for a specific 
version of a kernel. And, if it's not already working, the new driver 
model definitely won't help. :) 

> 2. Will the new model reduce the use/need for kernel modules. Would this be a 
> good thing if functionality could be implemented in a driver instead of a 
> module.

No, it will not reduce usage of modules. The driver model has nothing to 
do with whether something is compiled as a module or not. 

> 3. Will the practice of deliberately breaking some binary only 'tainted'
> modules prevent take up of Linux. Isn't this taking things too far?

This is a loaded question, but ultimately it's a vendor issue. Most people 
do and will use vendor kernels. What they do with their kernel interfaces 
and how well they support binary modules is their beef. 


	Pat

