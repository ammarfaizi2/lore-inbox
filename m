Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbVBTKq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVBTKq6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 05:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVBTKq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 05:46:58 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:60580
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261809AbVBTKqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 05:46:54 -0500
Subject: Re: updated list of unused kernel exports posted
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Arjan van de Ven <arjan@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1108847674.6304.158.camel@laptopd505.fenrus.org>
References: <1108847674.6304.158.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sun, 20 Feb 2005 11:46:52 +0100
Message-Id: <1108896413.24721.356.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-02-19 at 22:14 +0100, Arjan van de Ven wrote:
> +wait_for_completion_interruptible
> +wait_for_completion_interruptible_timeout
> +wait_for_completion_timeout

These are "emerging functionality" type. 

There are some patches in the pipeline, which make use of this and
waited for inclusion of those functions into mainline. I will
rework/rediff them after 2.6.11 is released.

tglx


