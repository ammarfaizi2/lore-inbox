Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVDSJeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVDSJeu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 05:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVDSJet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 05:34:49 -0400
Received: from hell.sks3.muni.cz ([147.251.210.30]:59527 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S261437AbVDSJeX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 05:34:23 -0400
Date: Tue, 19 Apr 2005 11:34:20 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: E1000 - page allocation failure - saga continues :(
Message-ID: <20050419093420.GB30268@mail.muni.cz>
References: <20050414214828.GB9591@mail.muni.cz> <4263A3B7.6010702@univ-nantes.fr> <20050418122202.GE26030@mail.muni.cz> <4264B202.9080304@univ-nantes.fr> <1113897810.5074.66.camel@npiggin-nld.site> <4264BE1F.50508@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4264BE1F.50508@univ-nantes.fr>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 10:15:27AM +0200, Yann Dupont wrote:
> >Possibly kswapd might be unable to get enough CPU to free memory.

I do not see why NIC rather does not drop packets instead of running out of
memory.

I know that renicing kswapd helps. But still do not see why 2.6.6 kernel works.

-- 
Luká¹ Hejtmánek
