Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262620AbVBYAWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbVBYAWd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 19:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbVBYAUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 19:20:32 -0500
Received: from news.suse.de ([195.135.220.2]:37074 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262620AbVBYARs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 19:17:48 -0500
To: hpa@zytor.com
Cc: linux-kernel@vger.kernel.org
Subject: raid6altivec does not compile on ppc32
From: Andreas Schwab <schwab@suse.de>
X-Yow: I feel real SOPHISTICATED being in FRANCE!
Date: Fri, 25 Feb 2005 01:17:46 +0100
Message-ID: <jebra9fq6t.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On ppc32 cur_cpu_spec is an array of pointers, not just a pointer like on
ppc64.

drivers/md/raid6altivec1.c: In function `raid6_have_altivec':
drivers/md/raid6altivec1.c:111: error: request for member `cpu_features' in something not a structure or union

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
