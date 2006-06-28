Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWF1HSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWF1HSC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 03:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932759AbWF1HSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 03:18:02 -0400
Received: from www.osadl.org ([213.239.205.134]:38871 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932758AbWF1HSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 03:18:00 -0400
Subject: Re: 2.6.17-mm3: arm: *_irq_wake compile error
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org, mingo@elte.hu,
       rmk@arm.linux.org.uk
In-Reply-To: <20060628001208.2b034afd.akpm@osdl.org>
References: <20060627015211.ce480da6.akpm@osdl.org>
	 <20060627224038.GF13915@stusta.de>
	 <1151478544.25491.485.camel@localhost.localdomain>
	 <20060628001208.2b034afd.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 09:20:03 +0200
Message-Id: <1151479204.25491.491.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-28 at 00:12 -0700, Andrew Morton wrote:
> OK, so I moved the above lines inside #ifdef CONFIG_GENERIC_HARDIRQS (diff
> did a strange-looking thing with it):

Yeah, but its nevertheless correct. :)

	tglx


