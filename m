Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316364AbSGLNYS>; Fri, 12 Jul 2002 09:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316390AbSGLNYR>; Fri, 12 Jul 2002 09:24:17 -0400
Received: from pD9E235D3.dip.t-dialin.net ([217.226.53.211]:46723 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316364AbSGLNYR>; Fri, 12 Jul 2002 09:24:17 -0400
Date: Fri, 12 Jul 2002 07:26:52 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: David Woodhouse <dwmw2@infradead.org>
cc: Dawson Engler <engler@csl.Stanford.EDU>, <linux-kernel@vger.kernel.org>,
       <mc@cs.Stanford.EDU>
Subject: Re: [CHECKER] 56 potential lock/unlock bugs in 2.5.8 
In-Reply-To: <32493.1026479849@redhat.com>
Message-ID: <Pine.LNX.4.44.0207120726310.3421-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 12 Jul 2002, David Woodhouse wrote:
> That one can't ever actually happen -- it's effectively a default case in a
> switch statement which can't ever be reached because we'd never get that far
> unless one of the real cases is going to be taken. I think I'll replace the
> return statement with panic("The world is broken");

But don't forget to unlock_kernel() before ;-)

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

