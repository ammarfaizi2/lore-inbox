Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVCUNzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVCUNzR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 08:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVCUNzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 08:55:17 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:20892 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261792AbVCUNzG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 08:55:06 -0500
In-Reply-To: <Pine.LNX.4.61.0503111609001.9384@blarg.somerset.sps.mot.com>
References: <Pine.LNX.4.61.0503111609001.9384@blarg.somerset.sps.mot.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Message-Id: <43b769d454b49bc3f33414912c7fa3ab@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] ppc32: emulate load/store string instructions
Date: Sat, 19 Mar 2005 15:36:00 +0100
To: Kumar Gala <galak@freescale.com>
X-Mailer: Apple Mail (2.619.2)
X-MIMETrack: Itemize by SMTP Server on D12ML064/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 21/03/2005 14:55:02,
	Serialize by Router on D12ML064/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 21/03/2005 14:55:02,
	Serialize complete at 21/03/2005 14:55:02
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	/* Early out if we are an invalid form of lswi */
> +	if ((instword & INST_STRING_MASK) == INST_LSWX)

Typo --------------------------------------------^


Segher

