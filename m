Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVBOUVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVBOUVh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 15:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVBOUVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 15:21:37 -0500
Received: from one.firstfloor.org ([213.235.205.2]:58505 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261845AbVBOUMp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 15:12:45 -0500
To: Andreas Deresch <aderesch@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: panic during IO-APIC detection
References: <Pine.LNX.4.62.0502161701300.10460@Magrathea>
From: Andi Kleen <ak@muc.de>
Date: Tue, 15 Feb 2005 21:12:41 +0100
In-Reply-To: <Pine.LNX.4.62.0502161701300.10460@Magrathea> (Andreas
 Deresch's message of "Wed, 16 Feb 2005 17:26:22 +0100 (CET)")
Message-ID: <m1sm3xh9ae.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Deresch <aderesch@fs.tum.de> writes:
>
> The question is, should io_apic_get_unique_id be more fault tolerant, or
> where else should this be fixed?

Patch makes sense in theory, but I suspect there is more state to fix
up to get rid of the IO-APIC than just decreasing nr_ioapics.

-Andi

