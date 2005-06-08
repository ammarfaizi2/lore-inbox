Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVFHSuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVFHSuH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 14:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVFHSuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 14:50:07 -0400
Received: from hell.sks3.muni.cz ([147.251.210.30]:31248 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S261517AbVFHStb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 14:49:31 -0400
Date: Wed, 8 Jun 2005 20:49:33 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Scott Bardone <sbardone@chelsio.com>
Cc: Francois Romieu <romieu@fr.zoreil.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.12-rc6-mm1 & Chelsio driver
Message-ID: <20050608184933.GC2369@mail.muni.cz>
References: <8A71B368A89016469F72CD08050AD3340255F0@maui.asicdesigners.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8A71B368A89016469F72CD08050AD3340255F0@maui.asicdesigners.com>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 10:33:09AM -0700, Scott Bardone wrote:
> You can download the N210/N110 (ver 2.1.1) from the Chelsio website and use
> that driver for the T110 with a newer kernel. I have tested that driver up to
> the 2.6.11 kernel release. It will provide you NIC mode functinoality on your
> T110 TOE card, you can use it as a module, or try to patch it into a later
> kernel. If patching it into a kernel, you may need to modify the patch a bit.

Thanks, however, without CONFIG_CHELSIO_T1_OFFLOAD card is not detected (no
wonder, driver enables T110 card only if offload is used). I do not need TCP
offload engine. With T1 Offload it cannot be compiled - it reject
cxgbtoe-2.1.1-linux-2.6.6-toe_api.patch

So, do I really need Offloading in kernel or should it work with just enableing
card in sources even without Offloading?

-- 
Luká¹ Hejtmánek
