Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264139AbRFDMDJ>; Mon, 4 Jun 2001 08:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264209AbRFDMC7>; Mon, 4 Jun 2001 08:02:59 -0400
Received: from 246.35.232.212.infosources.fr ([212.232.35.246]:39941 "HELO
	fjord.dyndns.org") by vger.kernel.org with SMTP id <S264139AbRFDMCr>;
	Mon, 4 Jun 2001 08:02:47 -0400
Date: Mon, 4 Jun 2001 14:02:07 +0200
To: linux-kernel@vger.kernel.org
Subject: ide retry on 2.4.5-ac7
Message-ID: <20010604140207.A529@alezan.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
From: profeta@crans.ens-cachan.fr (PROFETA Mickael)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

	Since my first try on 2.4 kernel, I had trouble with DMA when I select
	activate on boot time because it selects udma4, whereas my HD is only able
	to do udma2. I correct that with hdparm, but I was quite happy of the patch
	in ac4 whixh detect ide lost interrupt and retry with a value lower of dma.
	But it seems that this patch does not work anymore in ac7?? I can not see
	in the changelog that you come back or made other change in ide?? Should it
	work in the same way or not?

	My hardware: via 686a of course, with Athlon 500 on a k7m MB

		Thanks

		Mickael

	PS: CC to profeta@crans.org please.

-- 
-- 
Unix IS user-friendly. It just chooses its friends carefully
