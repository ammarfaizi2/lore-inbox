Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbVAOPB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbVAOPB0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 10:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbVAOPB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 10:01:26 -0500
Received: from mx1.elte.hu ([157.181.1.137]:50364 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262289AbVAOPBZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 10:01:25 -0500
Date: Sat, 15 Jan 2005 16:00:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, torvalds@osdl.org, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64 had _raw_read_trylock already
Message-ID: <20050115150040.GD16517@elte.hu>
References: <16868.64050.640925.128469@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16868.64050.640925.128469@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Mackerras <paulus@samba.org> wrote:

> Ingo presumably didn't notice that ppc64 already had a functional
> _raw_read_trylock when he added the #define to use the generic
> version.  This just removes the #define so we use the ppc64-specific
> version again.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

yeah - sorry.

	Ingo
