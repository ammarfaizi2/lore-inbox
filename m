Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268835AbRHPVal>; Thu, 16 Aug 2001 17:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268859AbRHPVab>; Thu, 16 Aug 2001 17:30:31 -0400
Received: from dryline-fw.yyz.somanetworks.com ([216.126.67.45]:63316 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S268835AbRHPVaT>; Thu, 16 Aug 2001 17:30:19 -0400
Subject: Re: Dell I8000, 2.4.8-ac5 and APM
From: Georg Nikodym <georgn@somanetworks.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200108162056.WAA18756@harpo.it.uu.se>
In-Reply-To: <200108162056.WAA18756@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 16 Aug 2001 17:30:32 -0400
Message-Id: <997997432.3007.1.camel@keller>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Aug 2001 22:56:46 +0200, Mikael Pettersson wrote:

> Try the patch below and configure with CONFIG_X86_UP_APIC disabled.
> Reboot. Pull the AC plug. What debug output did apm.c dump in the
> kernel log? If it said something about send_event() ignoring some
> event, then that's a prime suspect.

Each plug/unplug event generates:

apm: received power status change notify
apm: send_event() ignore event 0x06 (power status change)

