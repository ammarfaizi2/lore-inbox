Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965335AbWKTPTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965335AbWKTPTk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 10:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965600AbWKTPTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 10:19:40 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38572 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965335AbWKTPTj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 10:19:39 -0500
Date: Mon, 20 Nov 2006 15:25:05 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: avl@logic.at
Cc: linux-kernel@vger.kernel.org
Subject: Re: possible bug in ide-disk.c (2.6.18.2 but also older)
Message-ID: <20061120152505.5d0ba6c5@localhost.localdomain>
In-Reply-To: <20061120145148.GQ6851@gamma.logic.tuwien.ac.at>
References: <20061120145148.GQ6851@gamma.logic.tuwien.ac.at>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006 15:51:48 +0100
Andreas Leitgeb <avl@logic.at> wrote:

> Since I got not even a beep as answer, I'm trying again
> to get this through to someone who cares:

Sounds like the Knoppix kernel is built with GPT partition handling and
your disk has an odd number of sectors ?

> The problem is in  idedisk_read_native_max_address()
> and equivalently in idedisk_read_native_max_address_ext()
> in a line like this (near the end):
>   addr++; /* since the return value is (maxlba - 1), we add 1 */
> 
> I believe that this is wrong, in so far as it is device-specific.

Which part of the standard are you referring to here ?

Alan
