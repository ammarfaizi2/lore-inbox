Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264688AbSKNKvE>; Thu, 14 Nov 2002 05:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264839AbSKNKvE>; Thu, 14 Nov 2002 05:51:04 -0500
Received: from zamok.crans.org ([138.231.136.6]:25479 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id <S264688AbSKNKvD>;
	Thu, 14 Nov 2002 05:51:03 -0500
Date: Thu, 14 Nov 2002 11:57:55 +0100
To: Joyce Tan <blutot@yahoo.com>
Cc: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: No keyboard when 2.5.47 boots
Message-ID: <20021114105755.GA19729@darwin.crans.org>
References: <20021114100608.89194.qmail@web41013.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021114100608.89194.qmail@web41013.mail.yahoo.com>
User-Agent: Mutt/1.4i
X-Warning: Email may contain unsmilyfied humor and/or satire.
From: Vincent Hanquez <tab@tuxfamily.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 02:06:08AM -0800, Joyce Tan wrote:
> Hi,
> 
> I compiled linux-2.5.47 but when my linux reboots, the
> keyboard is not present.

> # CONFIG_SERIO is not set

you need
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
for a ps/2 keyboard

-- 
Tab
