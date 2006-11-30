Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933941AbWK3KPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933941AbWK3KPm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 05:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934264AbWK3KPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 05:15:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:2251 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S933941AbWK3KPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 05:15:41 -0500
From: Andreas Schwab <schwab@suse.de>
To: Nick Piggin <npiggin@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch 1/3] mm: pagecache write deadlocks zerolength fix
References: <20061130072058.GA18004@wotan.suse.de>
X-Yow: I just remembered something about a TOAD!
Date: Thu, 30 Nov 2006 11:15:39 +0100
In-Reply-To: <20061130072058.GA18004@wotan.suse.de> (Nick Piggin's message of
	"Thu, 30 Nov 2006 08:20:58 +0100")
Message-ID: <jeodqptf3o.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <npiggin@suse.de> writes:

> writev with a zero-length segment is a noop, and we shouldn't return EFAULT.

AFAICS the callers of these functions never pass a zero length.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
