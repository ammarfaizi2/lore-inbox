Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263718AbUELUtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263718AbUELUtr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 16:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263734AbUELUtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 16:49:47 -0400
Received: from ns.suse.de ([195.135.220.2]:13736 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263718AbUELUtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 16:49:41 -0400
To: Jan Olderdissen <jan@ixiacom.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: MSEC_TO_JIFFIES is messed up...
References: <15FDCE057B48784C80836803AE3598D50627ACD5@racerx.ixiacom.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Tex SEX!  The HOME of WHEELS!  The dripping of COFFEE!!  Take me
 to Minnesota but don't EMBARRASS me!!
Date: Wed, 12 May 2004 22:49:34 +0200
In-Reply-To: <15FDCE057B48784C80836803AE3598D50627ACD5@racerx.ixiacom.com> (Jan
 Olderdissen's message of "Wed, 12 May 2004 13:40:18 -0700")
Message-ID: <je4qqlpe01.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Olderdissen <jan@ixiacom.com> writes:

> Couple nitpicks:
>
>> #define	MSEC_TO_JIFFIES(msec) (msec * 10)

#define	MSEC_TO_JIFFIES(msec) ((msec) * 10)

>> #define JIFFIES_TO_MESC(jiffies) (jiffies / 10)
>
> #define JIFFIES_TO_MSEC(jiffies) (jiffies / 10)

#define JIFFIES_TO_MSEC(jiffies) ((jiffies) / 10)

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
