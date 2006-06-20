Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbWFTFXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbWFTFXz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 01:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWFTFWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 01:22:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63178 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965004AbWFTFWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 01:22:20 -0400
Date: Mon, 19 Jun 2006 22:22:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch -mm 16/20] chardev: GPIO for SCx200 & PC-8736x:  fix
 gpio_current, use shadow regs
Message-Id: <20060619222218.bb19e516.akpm@osdl.org>
In-Reply-To: <44944BD0.5050302@gmail.com>
References: <448DB57F.2050006@gmail.com>
	<cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
	<44944BD0.5050302@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2006 12:37:04 -0600
Jim Cromie <jim.cromie@gmail.com> wrote:

> +	return pc8736x_gpio_shadow[port] >> bit & 0x01;

<brain hurts>

You must know your C predence well...
