Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264625AbTANP7H>; Tue, 14 Jan 2003 10:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbTANP7H>; Tue, 14 Jan 2003 10:59:07 -0500
Received: from franka.aracnet.com ([216.99.193.44]:6066 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264625AbTANP7D>; Tue, 14 Jan 2003 10:59:03 -0500
Date: Tue, 14 Jan 2003 08:07:53 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: anyone have a 16-bit x86 early_printk?
Message-ID: <485650000.1042560472@titus>
In-Reply-To: <20030114113036.GG940@holomorphy.com>
References: <20030114113036.GG940@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm trying to get a box to boot and it appears to drop dead before
> start_kernel(). Would anyone happen to have an early_printk() analogue
> for 16-bit x86 code?

See arch/i386/boot/compressed/misc.c - there's a puts() routine in 
there that should work for most things OK.

M.

