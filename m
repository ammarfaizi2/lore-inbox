Return-Path: <linux-kernel-owner+w=401wt.eu-S1752647AbWLYSvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbWLYSvV (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 13:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752625AbWLYSvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 13:51:21 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:3677 "EHLO
	mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbWLYSvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 13:51:20 -0500
To: Olivier Galibert <galibert@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] MMCONFIG: Fix x86_64 ioremap base_address
References: <lrfyb7ctm8.fsf@dhcp-0242.miraclelinux.com>
	<1166869244.3281.590.camel@laptopd505.fenrus.org>
	<87fyb6n86a.fsf@duaron.myhome.or.jp>
	<1167050198.3281.1635.camel@laptopd505.fenrus.org>
	<20061225154920.GA87768@dspnet.fr.eu.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 26 Dec 2006 03:50:59 +0900
In-Reply-To: <20061225154920.GA87768@dspnet.fr.eu.org> (Olivier Galibert's message of "Mon\, 25 Dec 2006 16\:49\:23 +0100")
Message-ID: <87ac1bx10s.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert <galibert@pobox.com> writes:

> Sorry I missed the original email, but what is the chipset (name, pci
> ID) of the board(s) with the problematic bios?

I don't know, here is a comment of current code.

	/* Handle more broken MCFG tables on Asus etc.
	   They only contain a single entry for bus 0-0. Assume
	   this applies to all busses. */
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
