Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262331AbUKQOoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbUKQOoG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 09:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbUKQOoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 09:44:06 -0500
Received: from mail.convergence.de ([212.227.36.84]:37604 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S262331AbUKQOoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 09:44:03 -0500
Date: Wed, 17 Nov 2004 15:47:48 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: LinuxTV.org@stusta.de, Project@stusta.de, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-dvb-maintainer] [2.6 patch] kill dvb_ksyms.c
Message-ID: <20041117144748.GB6084@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Adrian Bunk <bunk@stusta.de>, LinuxTV.org@stusta.de,
	Project@stusta.de, linux-dvb-maintainer@linuxtv.org,
	linux-kernel@vger.kernel.org
References: <20041117120117.GM4943@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041117120117.GM4943@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 01:01:17PM +0100, Adrian Bunk wrote:
> The patch below removes drivers/media/dvb/dvb-core/dvb_ksyms.c and moves 
> the EXPORT_SYMBOL's to the files where the functions are.

OK

> In drivers/media/dvb/dvb-core/dvbdev.c, I've also fixed the wromg 
> indention in the second half of the function dvb_unregister_device
> (no code changes).

That was already corrected in our tree.

I've applied your patch to linuxtv.org CVS.

We've made some changes to the frontend probing code which
needs more testing (some card/frontend combinations are
broken), so we won't submit a new patchset before 2.6.10
is out.

Thanks,
Johannes
