Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbVASX33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVASX33 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 18:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVASX1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 18:27:12 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:10648
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261976AbVASX0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 18:26:14 -0500
Subject: Re: [PATCH] dynamic tick patch
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: george@mvista.com
Cc: Andrea Arcangeli <andrea@suse.de>, Tony Lindgren <tony@atomide.com>,
       Pavel Machek <pavel@suse.cz>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <41EEE648.2010309@mvista.com>
References: <20050119000556.GB14749@atomide.com>
	 <20050119094342.GB25623@elf.ucw.cz> <20050119171323.GB14545@atomide.com>
	 <20050119174858.GB12647@dualathlon.random>  <41EEE648.2010309@mvista.com>
Content-Type: text/plain
Date: Thu, 20 Jan 2005 00:26:11 +0100
Message-Id: <1106177171.16877.274.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-19 at 14:59 -0800, George Anzinger wrote:
> I don't think you will ever get good time if you EVER reprogramm the PIT.

Why not ? If you have a continous time source, which keeps track of
"ticks" regardless the CPU state, why should PIT reprogramming be evil ?

tglx


