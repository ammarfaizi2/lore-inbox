Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265103AbRFZV32>; Tue, 26 Jun 2001 17:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265108AbRFZV3T>; Tue, 26 Jun 2001 17:29:19 -0400
Received: from euclide.bretagne.ens-cachan.fr ([193.52.92.2]:19900 "EHLO
	euclide.bretagne.ens-cachan.fr") by vger.kernel.org with ESMTP
	id <S265103AbRFZV3N>; Tue, 26 Jun 2001 17:29:13 -0400
To: jsimmons@transvirtual.com
Cc: Linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <1evmtnt.1yhx1hb1pz56vyM%dolbeaur@club-internet.fr>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbgen & multiple RGBA
From: dolbeaur@club-internet.fr (Romain Dolbeau)
Date: Tue, 26 Jun 2001 23:28:45 +0200
Message-ID: <1evmufr.5f0v2ptqkcayM%dolbeaur@club-internet.fr>
Organization: IRISA
User-Agent: MacSOUP/F-2.4.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Romain Dolbeau wrote:

> If on your console you do a 'fbset -depth 16 -rgba 5,6,5,0' followed by
> a 'fbset -depth 16 -rgba 5,5,5,1' [1], any driver using fbdev will end
                                                         ^^^^^^^^
That should have been 'fbgen', sorry for the momentary lapse of reason
and the waste of bandwith.

> up with a crazy colormap because it hasn't been reinstalled after the
> RGBA change.

-- 
DOLBEAU Romain               | The Gods made Heavy Metal
ENS Cachan / Ker Lann        |     and it's never gonna die
Thesard IRISA / CAPS         |           -- Manowar
dolbeaur@club-internet.fr    | in 'The Gods made Heavy Metal'
