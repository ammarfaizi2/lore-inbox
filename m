Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264357AbUFDMye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264357AbUFDMye (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 08:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265781AbUFDMye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 08:54:34 -0400
Received: from hell.sks3.muni.cz ([147.251.210.31]:34212 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S265777AbUFDMyd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 08:54:33 -0400
Date: Fri, 4 Jun 2004 14:54:29 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: HDA DMA Timeout issue
Message-ID: <20040604125429.GB31375@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

in my notebook I sometimes see:

hda: dma_timer_expiry: dma status == 0x20
hda: DMA timeout retry
hda: timeout waiting for DMA
hda: status timeout: status=0xd0 { Busy }

hda: drive not ready for command
ide0: reset: success

It happened when I do scp from network or tar xjf kerneltree

It seems that notebook is just not fast enough to not fulfill DMA request.

Is something I could do?

-- 
Luká¹ Hejtmánek
