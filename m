Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292951AbSBVSXT>; Fri, 22 Feb 2002 13:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292952AbSBVSXJ>; Fri, 22 Feb 2002 13:23:09 -0500
Received: from mail.scs.ch ([212.254.229.5]:10118 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id <S292951AbSBVSXD>;
	Fri, 22 Feb 2002 13:23:03 -0500
Message-ID: <3C768C80.C5C3DBE@scs.ch>
Date: Fri, 22 Feb 2002 19:22:56 +0100
From: Thomas Sailer <sailer@scs.ch>
Reply-To: t.sailer@alumni.ethz.ch
Organization: SCS
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-21jnx i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Samium Gromoff <root@ibe.miee.ru>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Ess Solo-1 interrupt behaviour
In-Reply-To: <200202191412.g1JECvV12317@ibe.miee.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samium Gromoff wrote:
> "  Alan Cox wrote:"
> > Yes. It has diff fragment limits
>         So the point is we should fix esd, not the solo-1 driver, i presume?
>         (esd_fixed -> irq_load_fixed -> disk_io_is_back)... sounds ok

Note that solo1 has differnet limits depending whether the program (esd)
runs as root or not. root may shoot him/herself into the foot...

Tom
