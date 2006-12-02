Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162841AbWLBI5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162841AbWLBI5J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 03:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162842AbWLBI5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 03:57:09 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:3038 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1162841AbWLBI5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 03:57:07 -0500
Date: Sat, 2 Dec 2006 09:56:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/4] [APIC] Allow disabling of UP APIC/IO-APIC by default, with command line option to turn it on.
Message-ID: <20061202085654.GC20509@elte.hu>
References: <11648607683157-git-send-email-bcollins@ubuntu.com> <11648607732981-git-send-email-bcollins@ubuntu.com> <20061201083900.GA26703@elte.hu> <1165006596.5257.966.camel@gullible>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165006596.5257.966.camel@gullible>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ben Collins <ben.collins@ubuntu.com> wrote:

> So while "ioapic" might make more sense, it's doesn't match the 
> opposing command line option of "noapic".
> 
> I could include this in the diff:
> 
> +/* "noapic" is for backward compatibility */
>  early_param("noapic", parse_noapic);
> +early_param("noioapic", parse_noapic);
> 
> And then add the "ioapic" option.

makes sense i think.

	Ingo
