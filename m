Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbWBMNYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWBMNYZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 08:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWBMNYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 08:24:25 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:44680
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932432AbWBMNYZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 08:24:25 -0500
Subject: Re: [PATCH 04/13] hrtimer: remove nsec_t
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0602130209590.23812@scrub.home>
References: <Pine.LNX.4.61.0602130209590.23812@scrub.home>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 14:24:50 +0100
Message-Id: <1139837090.2480.475.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-13 at 02:10 +0100, Roman Zippel wrote:
> nsec_t predates ktime_t and has mostly been superseded by it. In the few
> places that are left it's better to make it explicit that we're dealing
> with 64 bit values here.
> 
> Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

Acked-by: Thomas Gleixner <tglx@linutronix.de>


