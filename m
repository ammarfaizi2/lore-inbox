Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288583AbSADK3D>; Fri, 4 Jan 2002 05:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288585AbSADK2n>; Fri, 4 Jan 2002 05:28:43 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:38663 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S288583AbSADK2h>; Fri, 4 Jan 2002 05:28:37 -0500
Date: Fri, 4 Jan 2002 11:28:34 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dmitri Pogosyan <pogosyan@phys.ualberta.ca>, linux-kernel@vger.kernel.org
Subject: Re: ASUS KT266A/VT8233 board and UDMA setting
Message-ID: <20020104112834.A20724@suse.cz>
In-Reply-To: <20020104102507.A20412@suse.cz> <E16MRhE-0003Rx-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16MRhE-0003Rx-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jan 04, 2002 at 10:35:32AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 10:35:32AM +0000, Alan Cox wrote:

> > Some RH kernels (may include yours) deliberately disable UDMA3, 4 and 5
> > on any VIA IDE controller. I don't know why. Unpatch your kernel and
> > it'll likely work.
> 
> RH 2.4.2-x. That was before we had the official VIA solution to the chipset
> bug. It was better to be safe than sorry for an end user distro.

But ... did this (limiting UDMA to 2) stop the bug from being manifested?

-- 
Vojtech Pavlik
SuSE Labs
