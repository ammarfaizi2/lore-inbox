Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbTFPUhZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 16:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbTFPUhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 16:37:25 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:3594 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264266AbTFPUhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 16:37:24 -0400
Date: Mon, 16 Jun 2003 21:51:16 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Zoup <Zoup@zoup.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.71 Frame Buffer Problem
In-Reply-To: <200306162349.57606.Zoup@zoup.org>
Message-ID: <Pine.LNX.4.44.0306162149480.26878-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi :)
> I'm using Albatron Ti4200 graphic card and i can't get 
> frame buffer working on VGA 788 or 790 , 2.5.71 config file 
> attached . 

Ugh. You have the vga16, vesa, and NVIDIA framebuffer drivers enabled. 
The NVIDIA driver might not work with your card. The VESA will so you 
should only enable that. Also you enabled both VGA console and frmaebuffer 
console. Please only enable framebuffer console.


