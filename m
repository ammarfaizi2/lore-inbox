Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265248AbUG0MdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbUG0MdM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 08:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbUG0MdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 08:33:11 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:21955 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S265315AbUG0Ma2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 08:30:28 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Marcin Owsiany <marcin@owsiany.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "swap_free: Unused swap offset entry 00000100" but no crash? 
In-reply-to: Your message of "Tue, 27 Jul 2004 02:21:54 +0200."
             <20040727002154.GA21628@melina.ds14.agh.edu.pl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 27 Jul 2004 22:30:02 +1000
Message-ID: <3808.1090931402@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004 02:21:54 +0200, 
Marcin Owsiany <marcin@owsiany.pl> wrote:
>    kernel: swap_free: Unused swap offset entry 00000100
>Also, I would be grateful if someone could explain what is that number in the
>message supposed to be? An address?

It is a swap partition number, but I doubt that you have 256 swap
partitions in your system.  Single bit set in a word that is meant to
be 0, most likely to be caused by a hardware single bit error.  Run
memtest, burn86 or other memory verification checks.

