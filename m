Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262595AbVAEV2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262595AbVAEV2J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 16:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbVAEV2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 16:28:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:2972 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262595AbVAEV1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 16:27:51 -0500
Date: Wed, 5 Jan 2005 13:27:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark_H_Johnson@raytheon.com, bunk@stusta.de, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org, perex@suse.cz
Subject: Re: [Alsa-devel] Re: 2.6.10-mm1: ALSA ac97 compile error with
 CONFIG_PM=n
Message-Id: <20050105132711.70f74ecc.akpm@osdl.org>
In-Reply-To: <s5his6cm1re.wl@alsa2.suse.de>
References: <OF5A3BD386.A1A4C579-ON86256F7F.00688E0E@raytheon.com>
	<s5his6cm1re.wl@alsa2.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai <tiwai@suse.de> wrote:
>
> The default blocking behavior of OSS devices was changed recently.
>  When the device is in use, open returns -EBUSY immediately in the
>  latest version while it was blocked until released in the former
>  version.
> 

whoa.  That's a significant change in user-visible behaviour.  Why was this
done?
