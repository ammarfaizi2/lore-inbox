Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWGKSHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWGKSHS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWGKSHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:07:17 -0400
Received: from terminus.zytor.com ([192.83.249.54]:19879 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751172AbWGKSHQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:07:16 -0400
Message-ID: <44B3E8CD.8070409@zytor.com>
Date: Tue, 11 Jul 2006 11:07:09 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] AVR32: Fix invalid constraints for stcond
References: <11526218021728-git-send-email-hskinnemoen@atmel.com> <11526218022840-git-send-email-hskinnemoen@atmel.com> <11526218024091-git-send-email-hskinnemoen@atmel.com>
In-Reply-To: <11526218024091-git-send-email-hskinnemoen@atmel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haavard Skinnemoen wrote:
> Because gcc doesn't seem to like arch-dependent constraints in inline
> asm, we ended up using "m" as constraint for the stcond instruction.

Bunkum.  That would be a bug in the AVR32 gcc, but gcc handles 
arch-specific constraints in inline assembly all the time.  The kernel 
wouldn't compile for a large number of architectures otherwise.

	-hpa
