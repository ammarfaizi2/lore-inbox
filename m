Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbVCPALT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVCPALT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 19:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVCPAKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 19:10:23 -0500
Received: from gate.crashing.org ([63.228.1.57]:26027 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262179AbVCPAHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 19:07:00 -0500
Subject: Re: [PATCH] CONFIG_PM for ppc64, to allow sysrq o
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
In-Reply-To: <20050315212656.GA24563@suse.de>
References: <20050315212656.GA24563@suse.de>
Content-Type: text/plain
Date: Wed, 16 Mar 2005 11:04:44 +1100
Message-Id: <1110931484.25201.60.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-15 at 22:26 +0100, Olaf Hering wrote:
> For some weird reason, sysrq o is hidden behind CONFIG_PM.
> Why? One can power off just fine without that. Can pm_sysrq_init be
> moved to a better place? I think it used to be in sysrq.c in 2.4.
> 
> Too bad, with this patch radeonfb fails to compile.

Hehe :)

ppc64 isn't yet ready for CONFIG_PM, though I have some
hacks-in-progress ...

Ben.


