Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbVFHGud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVFHGud (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 02:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbVFHGud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 02:50:33 -0400
Received: from hell.sks3.muni.cz ([147.251.210.30]:35088 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S262114AbVFHGu2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 02:50:28 -0400
Date: Wed, 8 Jun 2005 08:50:30 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Scott Bardone <sbardone@chelsio.com>
Cc: Francois Romieu <romieu@fr.zoreil.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.12-rc6-mm1 & Chelsio driver
Message-ID: <20050608065030.GR2369@mail.muni.cz>
References: <20050607181300.GL2369@mail.muni.cz> <42A5EC7C.4020202@pobox.com> <20050607185845.GM2369@mail.muni.cz> <42A5F51B.5060909@pobox.com> <20050607193305.GN2369@mail.muni.cz> <20050607200820.GA25546@electric-eye.fr.zoreil.com> <20050607211048.GO2369@mail.muni.cz> <42A655C2.3030406@chelsio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42A655C2.3030406@chelsio.com>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 07:19:46PM -0700, Scott Bardone wrote:
> It looks like you have a T110 card (10Gb TOE) by the device ID 0006.
> The Chelsio driver which is in the 2.6 mm tree only supports the NIC model 
> cards (N110 & N210).
> 
> We currently don't have the TOE API in the Linux kernel so the TOE 
> functionality does not exist, therefore you can only use the Chelsio 
> modified 2.6.6 kernel for TOE.
> 
> You will need to download the driver from Chelsio's website for the T110. 
> Please send me an email if you don't have a login.

Thanks, we have an account. But I wonder whether T110 card could be used in
newer kernel (as 2.6.6 is rather old and cat /proc/iomap segfaults in kernel).

We do not need TOE functionality, UDP transfer is just fine.

-- 
Luká¹ Hejtmánek
