Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132825AbRDUTGX>; Sat, 21 Apr 2001 15:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132828AbRDUTGO>; Sat, 21 Apr 2001 15:06:14 -0400
Received: from nrg.org ([216.101.165.106]:38724 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S132825AbRDUTGA>;
	Sat, 21 Apr 2001 15:06:00 -0400
Date: Sat, 21 Apr 2001 12:05:55 -0700 (PDT)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Victor Julien <v.p.p.julien@let.rug.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3+ sound distortion
In-Reply-To: <01042118044700.01268@victor>
Message-ID: <Pine.LNX.4.05.10104211159030.5218-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Apr 2001, Victor Julien wrote:
> I have a problem with kernels higher than 2.4.2, the sound distorts when 
> playing a song with xmms while the seti@home client runs. 2.4.2 did not have 
> this problem. I tried 2.4.3, 2.4.4-pre5 and 2.4.3-ac11. They al showed the 
> same problem.

Try running xmms as root with the "Use realtime priority when available"
option checked.  If the distortion is because xmms isn't getting enough
CPU time, then running it at a realtime priority will fix it.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

MontaVista Software                             nigel@mvista.com

