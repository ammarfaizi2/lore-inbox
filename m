Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317743AbSGPCy4>; Mon, 15 Jul 2002 22:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317744AbSGPCyz>; Mon, 15 Jul 2002 22:54:55 -0400
Received: from moutvdomng1.kundenserver.de ([195.20.224.131]:40132 "EHLO
	moutvdomng1.kundenserver.de") by vger.kernel.org with ESMTP
	id <S317743AbSGPCyy>; Mon, 15 Jul 2002 22:54:54 -0400
Date: Mon, 15 Jul 2002 20:57:46 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Hell.Surfers@cwctv.net
cc: hahn@physics.mcmaster.ca, <linux-kernel@vger.kernel.org>
Subject: Re: how to improve the throughput of linux network
In-Reply-To: <0fa130844021072DTVMAIL3@smtp.cwctv.net>
Message-ID: <Pine.LNX.4.44.0207152055080.3452-100000@hawkeye.luckynet.adm>
X-Location: Canberra; Australia
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 16 Jul 2002 Hell.Surfers@cwctv.net wrote:
> well only if it was used little amounts, like once every hour, it would
> dynamically unload in between,

That's ok then. It shouldn't produce significant overhead. But on the 
routers that I run I have either no netfilters at all, or they keep 
running, so even if they were a module, they'd never have any time to 
unload.

> and dont modules, recompile on each use?

No, because that would be pointless. And it would keep the kernel from 
running properly on systems without a c compiler.

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

