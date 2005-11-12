Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbVKLVhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbVKLVhU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 16:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbVKLVhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 16:37:19 -0500
Received: from ppp83-237-253-90.pppoe.mtu-net.ru ([83.237.253.90]:15596 "EHLO
	dwragg.oilspace.com") by vger.kernel.org with ESMTP id S932504AbVKLVhS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 16:37:18 -0500
To: =?utf-8?q?Pelle_Lundstr=C3=B6m?= <lunper@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: No initialization of sound card
In-Reply-To: <b1952ae90511121243q6c7e4c87x4f7bd99f7d3a86ee@mail.gmail.com>
From: David Wragg <david@wragg.org>
Date: Sat, 12 Nov 2005 21:34:00 +0000
Message-ID: <m3veyxo8jb.fsf@dwragg.oilspace.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-11-12 at 21:43 +0100, Pelle Lundström wrote:
> 1. Kernel 2.6.14.2 fails to locate and initiate sound card.

I have seen similar problems due to trailing spaces on option lines in
/etc/modprobe.com.  These get interpreted by the kernel as zero-length
options, causing similar "unknown parameter" errors. So check that
file, and remove any suspicious spaces at the ends of lines.

David Wragg
