Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264893AbTFQTTM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 15:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264895AbTFQTTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 15:19:12 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:19218 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264893AbTFQTTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 15:19:11 -0400
Date: Tue, 17 Jun 2003 20:33:04 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Zoup <Zoup@zoup.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.71 Frame Buffer Problem
In-Reply-To: <200306190057.14440.Zoup@zoup.org>
Message-ID: <Pine.LNX.4.44.0306172031110.21214-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> i had compile kernel 2.5.71 with VESA support (disabled nvidia driver ) , on 
> boot some lines and dotes dancing around the screen ! :) 

Hum. Like to see those bugs. 

> now i have remove VESA support and VGA Console , there is no blank screen 
> again but , i have seleted vga 791 ( 1025x768x256 ) and its working on 769 ( 
> 640x486x256 ) , i dont know why ! :) i have tested many times , you know 
> nvidia driver works under 2.4.* . 
> thanks 

vga=791 will not work for the rivafb driver. That is vesafb specific. You 
need to use modedb. See linux/Documentation/fb/modedb.txt.


P.S
   I think the modedb code is broken for the NVIDIA driver. I haven't got 
around to fixing that.

