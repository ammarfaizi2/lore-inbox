Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275210AbTHMMcv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 08:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275232AbTHMMcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 08:32:51 -0400
Received: from mail.suse.de ([213.95.15.193]:61455 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S275210AbTHMMcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 08:32:45 -0400
To: Adrian Reber <adrian@lisas.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vsnprintf patch
References: <20030813115212.GA28066@lisas.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Not SENSUOUS...  only ``FROLICSOME''...
 and in need of DENTAL WORK...  in PAIN!!!
Date: Wed, 13 Aug 2003 14:16:57 +0200
In-Reply-To: <20030813115212.GA28066@lisas.de> (Adrian Reber's message of
 "Wed, 13 Aug 2003 13:52:12 +0200")
Message-ID: <jehe4lsqfa.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Reber <adrian@lisas.de> writes:

|> When using the snprintf function from the kernel the length returned is
|> not the length written:
|> 
|> len = snprintf(test,1,"BLA 1"); 
|> 
|> len is 5 although test is "B"

Exactly how it should be.

|> the patch below fixes the symptom, but I am not sure if this is the real
|> solution for this problem.

There is no problem here.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
