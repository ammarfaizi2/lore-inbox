Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWCTIMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWCTIMX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 03:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWCTIMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 03:12:23 -0500
Received: from 213-140-2-70.ip.fastwebnet.it ([213.140.2.70]:63655 "EHLO
	aa003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932205AbWCTIMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 03:12:23 -0500
Date: Mon, 20 Mar 2006 09:12:47 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: "Matt LaPlante" <laplam@rpi.edu>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16: Two AES Options
Message-ID: <20060320091247.355fea06@localhost>
In-Reply-To: <000001c64bf3$f5659850$fe04a8c0@cyberdogt42>
References: <000001c64bf3$f5659850$fe04a8c0@cyberdogt42>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.8; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2006 02:57:38 -0500
"Matt LaPlante" <laplam@rpi.edu> wrote:

>   x x < >   AES cipher algorithms

This one is generic (crypto/aes.c).

> x x
>   x x < >   AES cipher algorithms (i586)

This one is written in assembly (arch/i386/crypto/...) and optimized
for i586+ processors.

So the second one should be faster...

-- 
	Paolo Ornati
	Linux 2.6.16 on x86_64
