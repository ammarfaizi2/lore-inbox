Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263922AbTEOGEA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 02:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263881AbTEOGEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 02:04:00 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:61456 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S263922AbTEOGD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 02:03:58 -0400
Date: Thu, 15 May 2003 16:16:15 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: jt@hpl.hp.com
cc: Jouni Malinen <jkmaline@cc.hut.fi>, Jeff Garzik <jgarzik@pobox.com>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: airo and firmware upload (was Re: 2.6 must-fix list, v3)
In-Reply-To: <20030515022034.GA12608@bougret.hpl.hp.com>
Message-ID: <Mutt.LNX.4.44.0305151610240.12581-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003, Jean Tourrilhes wrote:

> 	There is no RC4 currently in the crypto API (guess why), and I

If you mean because of IP issues, that's not the reason.  As far as I 
know, we can use 'arcfour', which is compatible.

Arcfour is also needed potentially for MPPE support (check for recent 
thread).

- James
-- 
James Morris
<jmorris@intercode.com.au>


