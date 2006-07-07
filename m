Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWGGXuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWGGXuR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWGGXuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:50:17 -0400
Received: from ns2.suse.de ([195.135.220.15]:35266 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751137AbWGGXuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:50:15 -0400
To: Adrian Bunk <bunk@stusta.de>
Cc: alsa-devel@alsa-project.org, perex@suse.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: OSS driver removal, 2nd round (v2)
References: <20060707231716.GE26941@stusta.de>
From: Andi Kleen <ak@suse.de>
Date: 08 Jul 2006 01:50:00 +0200
In-Reply-To: <20060707231716.GE26941@stusta.de>
Message-ID: <p737j2potzr.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:
> 
> Q: What about the OSS emulation in ALSA?
> A: The OSS emulation in ALSA is not affected by my patches
>    (and it's not in any way scheduled for removal).

I again object to removing the old ICH sound driver.
It does the same as the Alsa driver in much less code and is ideal
for generic monolithic kernels

-Andi
