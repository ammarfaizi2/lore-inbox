Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318787AbSHBLpb>; Fri, 2 Aug 2002 07:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318786AbSHBLpb>; Fri, 2 Aug 2002 07:45:31 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:26358 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318787AbSHBLpa>; Fri, 2 Aug 2002 07:45:30 -0400
Subject: Re: cs4281 driver cleanup (includes synchronize_irq() update)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: davidm@hpl.hp.com
Cc: twoller@crystal.cirrus.com, audio@crystal.cirrus.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <200208012331.g71NVWQP016779@napali.hpl.hp.com>
References: <200208012331.g71NVWQP016779@napali.hpl.hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 02 Aug 2002 14:06:18 +0100
Message-Id: <1028293578.18317.56.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-02 at 00:31, David Mosberger wrote:
> The patch below cleans up the cs4281 sound driver to compile cleanly
> (no warnings) on 64-bit platforms such as ia64.  Also, the patch
> updated the calls to synchronize_irq() according to the new interface
> (which takes an irq number as an argument).  Someone who understands
> this driver might want to double check that this is indeed working as
> intended.

I'll double check it and backport the changes to 2.4

