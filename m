Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbTLKFuq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 00:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264353AbTLKFuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 00:50:46 -0500
Received: from holomorphy.com ([199.26.172.102]:29924 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264260AbTLKFun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 00:50:43 -0500
Date: Wed, 10 Dec 2003 21:50:39 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Linux 2.6.0-test11 only lets me use 1GB out of 2GB ram.
Message-ID: <20031211055039.GY8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org
References: <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org> <3FD7FCF5.7030109@cyberone.com.au> <3FD801B3.7080604@wmich.edu> <20031211054111.GX8039@holomorphy.com> <52llpjykf8.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52llpjykf8.fsf@topspin.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William> 2:2 splits are at least technically ABI violations, which
William> is probably why this isn't merged etc. Applications
William> sensitive to it are uncommon.
William> Yes, the SVR4 i386 ELF/ABI spec literally mandates
William> 0xC0000000 as the top of the process address space.

On Wed, Dec 10, 2003 at 09:48:11PM -0800, Roland Dreier wrote:
> What about the 4G/4G split stuff for x86 (which is in 2.6 as well as
> the RH EL 3 kernel)?  It seems that would be just as big a violation
> of the ABI...

I oversimplified it. It only requires it to be at or above 0xC0000000,
so the 4/4 patches are compliant.


-- wli
