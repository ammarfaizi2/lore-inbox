Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUBWWIE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 17:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbUBWWIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 17:08:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:46732 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262062AbUBWWIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 17:08:02 -0500
Date: Mon, 23 Feb 2004 14:09:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michael Hunold <hunold@linuxtv.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, hunold@linuxtv.org
Subject: Re: [PATCH 7/9] tda1004x DVB frontend update
Message-Id: <20040223140943.7e58eb5c.akpm@osdl.org>
In-Reply-To: <10775702843054@convergence.de>
References: <10775702831806@convergence.de>
	<10775702843054@convergence.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Hunold <hunold@linuxtv.org> wrote:
>
>  	// read it!
> -	lseek(fd, tda10045h_fwinfo[fwinfo_idx].fw_offset, 0);
> +        lseek(fd, fw_offset, 0);
>  	if (read(fd, firmware, fw_size) != fw_size) {

was there some plan to convert DVB over to using the firmware loader?
