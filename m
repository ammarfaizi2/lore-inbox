Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264291AbTLKFsS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 00:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264353AbTLKFsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 00:48:18 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:56988 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S264291AbTLKFsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 00:48:16 -0500
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Linux 2.6.0-test11 only lets me use 1GB out of 2GB ram.
References: <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org>
	<3FD7FCF5.7030109@cyberone.com.au> <3FD801B3.7080604@wmich.edu>
	<20031211054111.GX8039@holomorphy.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 10 Dec 2003 21:48:11 -0800
In-Reply-To: <20031211054111.GX8039@holomorphy.com>
Message-ID: <52llpjykf8.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 11 Dec 2003 05:48:13.0626 (UTC) FILETIME=[5DD791A0:01C3BFAA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    William> 2:2 splits are at least technically ABI violations, which
    William> is probably why this isn't merged etc. Applications
    William> sensitive to it are uncommon.

    William> Yes, the SVR4 i386 ELF/ABI spec literally mandates
    William> 0xC0000000 as the top of the process address space.

What about the 4G/4G split stuff for x86 (which is in 2.6 as well as
the RH EL 3 kernel)?  It seems that would be just as big a violation
of the ABI...

 - Roland
