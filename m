Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285369AbSAGTU3>; Mon, 7 Jan 2002 14:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285347AbSAGTUX>; Mon, 7 Jan 2002 14:20:23 -0500
Received: from unknown-1-11.windriver.com ([147.11.1.11]:10917 "EHLO
	mail.wrs.com") by vger.kernel.org with ESMTP id <S285369AbSAGTT0>;
	Mon, 7 Jan 2002 14:19:26 -0500
From: mike stump <mrs@windriver.com>
Date: Mon, 7 Jan 2002 11:18:40 -0800 (PST)
Message-Id: <200201071918.LAA11997@kankakee.wrs.com>
To: dewar@gnat.com, guerby@acm.org
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, paulus@samba.org,
        trini@kernel.crashing.org, velco@fadata.bg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: dewar@gnat.com
> To: dewar@gnat.com, guerby@acm.org, mrs@windriver.com
> Date: Sun,  6 Jan 2002 14:32:01 -0500 (EST)

> Ah ha! But then look again at my 16-bit example, an expert assembly
> langauge programmer will use a 32 bit load if efficiency is not an
> issue (and it does not matter if there are extra bits around), but a
> 16-bit load if the hardware for some reason requires it. How is the
> poort C compiler to distinguish these cases automatically?

When you give the compiler as much information to it as your expert
apparently has, then it will produce the same code, until then,
imagine you told you expert that you want to do a 16 bit fetch for
something that might care if it were not a 16 bit access...  If you so
tie your experts hands, as you tie gcc hands, then should produce
similar code.

Now, if you want to invent gcc extensions so that it can know as much
as a domain expert, start proposing those language extensions...
