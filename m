Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbVLDPfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbVLDPfl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 10:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbVLDPfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 10:35:41 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:47375 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S932257AbVLDPfk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 10:35:40 -0500
Date: Sun, 4 Dec 2005 11:27:32 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Paulo da Silva <psdasilva@esoterica.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cannot run linux 2.6.14.3 UML on a x86_64
Message-ID: <20051204162732.GA3692@ccure.user-mode-linux.org>
References: <43924B2C.9000300@esoterica.pt> <20051204043205.GA15425@ccure.user-mode-linux.org> <43926CC8.2030902@esoterica.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43926CC8.2030902@esoterica.pt>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 04:12:56AM +0000, Paulo da Silva wrote:
> I did a mke2fs running on a 64 bits (x86_64) system.
> Is there a way to specify that a filesystem is for 64 bits?

Yeah, you fill it with either 64 or 32-bit binaries.

> I am using linux for 64 bits since a couple of days before.
> I did not patch the host kernel with skas yet.

UML no longer requires patching the host in order to use skas mode.

> Besides performance, is there any other reason to use it?

It works.  I have never really tested tt mode on x86_64.

				Jeff
