Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbWEBSgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWEBSgG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 14:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbWEBSgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 14:36:05 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:20421 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S964960AbWEBSgE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 14:36:04 -0400
Date: Tue, 2 May 2006 20:33:13 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: David Vrabel <dvrabel@cantab.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, david@pleyades.net
Subject: Re: [PATCH 2/3] ipg: leaks in ipg_probe
Message-ID: <20060502183313.GA26357@electric-eye.fr.zoreil.com>
References: <Pine.LNX.4.58.0604281458110.19801@sbz-30.cs.Helsinki.FI> <1146306567.1642.3.camel@localhost> <20060429122119.GA22160@fargo> <1146342905.11271.3.camel@localhost> <1146389171.11524.1.camel@localhost> <44554ADE.8030200@cantab.net> <4455F1D8.5030102@cantab.net> <1146506939.23931.2.camel@localhost> <20060501231050.GC7419@electric-eye.fr.zoreil.com> <Pine.LNX.4.58.0605020936420.4066@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0605020936420.4066@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg <penberg@cs.Helsinki.FI> :
[...]
> Is this tested with hardware?

No.

> Alignment of the start address looks bogus for sure, but any idea
> why they had it in the first place?

No clear idea but it matches the significant part of the BAR register
for the 256 bytes of I/O space that the device uses.

-- 
Ueimor
