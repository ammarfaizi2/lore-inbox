Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUL3VmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUL3VmB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 16:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbUL3VmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 16:42:00 -0500
Received: from maxipes.logix.cz ([217.11.251.249]:11192 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S261724AbUL3Vl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 16:41:56 -0500
Date: Thu, 30 Dec 2004 22:41:54 +0100 (CET)
From: Michal Ludvig <michal@logix.cz>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: davem@davemloft.com, jmorris@redhat.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [Patch?] padlock-aes.c used forward inline function
In-Reply-To: <200412301459.iBUExvU18246@freya.yggdrasil.com>
Message-ID: <Pine.LNX.4.61.0412302236530.19834@maxipes.logix.cz>
References: <200412301459.iBUExvU18246@freya.yggdrasil.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2004, Adam J. Richter wrote:

> 	gcc-3.4.3 and gcc-3.4.1 do not currently support forward
> declaration of inline functions, as is used in
> linux-2.6.10-rc2/drivers/crypto/padlock-aes.c.
> 
> 	The function is trivial, so it is better to inline it
> by defining it earlier than it would be to un-inline it.
> Here is a proposed patch.  If it looks okay, I would appreciate
> it if someone would bless it and forward it downstream.

I have already sent exactly the same patch directly to Andrew and Linus 
some days ago ;-)

Michal Ludvig
-- 
* A mouse is a device used to point at the xterm you want to type in.
* Personal homepage - http://www.logix.cz/michal
