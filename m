Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbTK1RKG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 12:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbTK1RKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 12:10:06 -0500
Received: from mx.laposte.net ([81.255.54.11]:52372 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S262740AbTK1RKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 12:10:01 -0500
Subject: Re: Tell user when ACPI is killing machine
From: Frederik Deweerdt <frederik.deweerdt@laposte.net>
To: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031128145558.GA576@elf.ucw.cz>
References: <20031128145558.GA576@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1070039237.3669.1.camel@silenus.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 28 Nov 2003 18:07:17 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-11-28 at 15:55, Pavel Machek wrote:
> +	printk(KERN_EMERG "Critical temperature reached (%d C), shutting down.\n", tz->temperature);
Maybe there should be a KELVIN_TO_CELSIUS conversion for
tz->temperature?

Regards,
Frederik Deweerdt
frederik.deweerdt@laposte.net

