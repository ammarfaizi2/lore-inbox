Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317873AbSGPPZf>; Tue, 16 Jul 2002 11:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317874AbSGPPZe>; Tue, 16 Jul 2002 11:25:34 -0400
Received: from p508875D5.dip.t-dialin.net ([80.136.117.213]:14481 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317873AbSGPPZd>; Tue, 16 Jul 2002 11:25:33 -0400
Date: Tue, 16 Jul 2002 09:27:45 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: William Lee Irwin III <wli@holomorphy.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NFS nonzero preempt_count 1/2
In-Reply-To: <20020716083714.GN1022@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0207160927000.3452-100000@hawkeye.luckynet.adm>
X-Location: Calgary; CA
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 16 Jul 2002, William Lee Irwin III wrote:
> @@ -1088,6 +1088,7 @@
>  	wake_up(assassin);
>  
>  	dprintk("RPC: rpciod exiting\n");
> +	unlock_kernel();
>  	MOD_DEC_USE_COUNT;
>  	return 0;
>  }

I wonder why the checker didn't yell on this. Wasn't it in the tree when 
the checker checked?

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

