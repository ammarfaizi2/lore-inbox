Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265776AbRFXWpW>; Sun, 24 Jun 2001 18:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265777AbRFXWpN>; Sun, 24 Jun 2001 18:45:13 -0400
Received: from jalon.able.es ([212.97.163.2]:908 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S265776AbRFXWox>;
	Sun, 24 Jun 2001 18:44:53 -0400
Date: Mon, 25 Jun 2001 00:48:22 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Sasi Peter <sape@iq.rulez.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] gcc 2.95.2 vs. 3.0 (fwd)
Message-ID: <20010625004822.C1799@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.33.0106241143220.30968-100000@iq.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.33.0106241143220.30968-100000@iq.rulez.org>; from sape@iq.rulez.org on Sun, Jun 24, 2001 at 11:54:25 +0200
X-Mailer: Balsa 1.1.6-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20010624 Sasi Peter wrote:
>
>I know opendivx code is not like kernel code at all, but on the other hand
>it is well suited for benchmark testing.
>
>
>test file:  (opendivx with postprocessing, this stuff is written in C)
># mplayer -osdlevel 0 -nosound -benchmark 1800.avi -vo null -pp 15
>VIDEO:  [divx]  640x352  24bpp  23.98 fps  1865.1 kbps (227.7 kbyte/s)
>

Sure it is opendivx ? I think you are just using gcc compiled code for
the 'interface' and 'glue' to windows divx decoders (/usr/lib/win32/*.dll)
that do the real hard work.

Redo the tests with am MPEG2 movie.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.5-ac17 #2 SMP Fri Jun 22 01:36:07 CEST 2001 i686
