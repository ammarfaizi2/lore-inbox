Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316677AbSILTEa>; Thu, 12 Sep 2002 15:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316705AbSILTEa>; Thu, 12 Sep 2002 15:04:30 -0400
Received: from pD9E23F87.dip.t-dialin.net ([217.226.63.135]:57061 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316677AbSILTE3>; Thu, 12 Sep 2002 15:04:29 -0400
Date: Thu, 12 Sep 2002 13:08:39 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Jim Sibley <jlsibley@us.ibm.com>
cc: Thunder from the hill <thunder@lightweight.ods.org>,
       <linux-kernel@vger.kernel.org>, Giuliano Pochini <pochini@shiny.it>,
       <riel@conectiva.com.br>
Subject: RE: Killing/balancing processes when overcommited
In-Reply-To: <OFDB91827C.152E85A4-ON88256C32.0067C0A4@boulder.ibm.com>
Message-ID: <Pine.LNX.4.44.0209121306550.10048-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 12 Sep 2002, Jim Sibley wrote:
> And this is not just limited to memory exhaustion. For example, if I exceed
> the maximum number of files, I can't log on to fix the problem. If the
> installation could set some priorities, they could say who to sacrifice in
> order to keep others running.

These problems can be solved via ulimit. I was referring to things like 
rsyncd which was blowing up under certain situations, but runs under a 
trusted account (say UID=0). In order to condemn it you'd need the setup 
I've mentioned.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

