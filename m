Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWEVLAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWEVLAM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 07:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWEVLAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 07:00:12 -0400
Received: from main.gmane.org ([80.91.229.2]:48546 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750737AbWEVLAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 07:00:11 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Bernd Pfrommer <pfrommer@yahoo.com>
Subject: Re: mcelog ?
Date: Sat, 20 May 2006 22:46:11 +0000 (UTC)
Message-ID: <loom.20060521T003831-723@post.gmane.org>
References: <20060515114243.8ccaa9aa.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 69.120.44.180 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski <skraw <at> ithnet.com> writes:

> 
> Hello,
> 
> can some kind soul please shortly explain what this message tells me:
> 
> HARDWARE ERROR
> CPU 1: Machine Check Exception:                4 Bank 4: b60a200170080813
> TSC 89cfb4725b17 ADDR 1025cb3f0 
> This is not a software problem!
> Run through mcelog --ascii to decode and contact your hardware vendor
> Kernel panic - not syncing: Machine check
> 
> Of course I ran mcelog but I don't quite understand how the additional info
> helps me finding the problem.
> Is this a problem with RAM? And if, which one?
> 
> The box is a dual opteron with two banks of mem (4 sockets each), each socket
> holding a 1 GB mem module.
> 
> Thanks for any hints.


I got a very similar error on a supermicro H8QC8+ (4way dual-core opteron)
during heavy disk writes. It only happened once so far. The error message also
mentioned
4 Bank 4: b608a00100000813 (strange that the last 4 digits agree).

Bernd


