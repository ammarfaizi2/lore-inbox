Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266365AbUG0Ilr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266365AbUG0Ilr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 04:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266363AbUG0Ilr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 04:41:47 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:9408 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S266366AbUG0Iku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 04:40:50 -0400
To: Matt Mackall <mpm@selenic.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete cryptoloop
References: <20040726200126.GQ5414@waste.org>
From: Junio C Hamano <junkio@cox.net>
Date: Tue, 27 Jul 2004 01:40:47 -0700
In-Reply-To: <fa.edslbgp.q763qd@ifi.uio.no> (Matt Mackall's message of "Mon,
 26 Jul 2004 20:40:16 GMT")
Message-ID: <7v4qntc06o.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "MM" == Matt Mackall <mpm@selenic.com> writes:

MM> Here's a scenario: corrupt government agency secretly watermarks
MM> incriminating documents. Brave whistleblower puts them on his laptop's
MM> cryptoloop fs, but gets taken aside by customs agents on his way out
MM> of the country. Agents check his disk for evidence of the watermark
MM> and find enough evidence...

Jari's exploit uses the property that his watermarks are
encrypted to identical ciphertext blocks, but does it mean that
the technique can be used to prove that identical ciphertext are
from the watermarks and not coming from mere coincidence?

