Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285691AbRLTATi>; Wed, 19 Dec 2001 19:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285669AbRLTATX>; Wed, 19 Dec 2001 19:19:23 -0500
Received: from ns.suse.de ([213.95.15.193]:13586 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S285691AbRLTATG>;
	Wed, 19 Dec 2001 19:19:06 -0500
Date: Thu, 20 Dec 2001 01:19:05 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Elyse Grasso <emgrasso@data-raptors.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: apm gpf on Inspiron2500 with 2.4.9
In-Reply-To: <20011220000357Z285654-18284+4575@vger.kernel.org>
Message-ID: <Pine.LNX.4.33.0112200117210.26043-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2001, Elyse Grasso wrote:

> EIP:  0050:[<00002ffb>]       Not tainted

The 0050 means you went bang in BIOS context.
See if theres a BIOS upgrade available.

If this is occuring at shutdown time, try the "Use real mode APM
BIOS call to power off" option in the APM section of the kernel
configuration.

Dave,

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

