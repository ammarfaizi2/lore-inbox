Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289842AbSBKQ7L>; Mon, 11 Feb 2002 11:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289844AbSBKQ7B>; Mon, 11 Feb 2002 11:59:01 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:30223 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S289842AbSBKQ6p>; Mon, 11 Feb 2002 11:58:45 -0500
Date: Mon, 11 Feb 2002 17:58:37 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: "Proescholdt, timo" <Timo.Proescholdt@brk-muenchen.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: randomness - compaq smart array driver
In-Reply-To: <410B51F29EA8D3118EE400508B44AE2B3C6FB3@RZ_NT_MAIL>
Message-ID: <Pine.LNX.4.33.0202111754560.5685-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2002, Proescholdt, timo wrote:

> I noticed that the installation fails due to missing randomness.
> I can confirm that as cat /dev/random does not provide any output.
[...]
> I heard that there is a patch for 2.2.x kernels, wich deals with this
> topic , but i cannot find this patch anywere .
> Is there a similar patch for 2.4.x kernels?

Robert Love did a patch to let network devices contribute to the random
pool. Look at
  ftp://www.*.kernel.org/pub/linux/kernel/people/rml/netdev-random/
or
  http://www.tech9.net/rml/linux/

Tim

