Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317835AbSGKNfc>; Thu, 11 Jul 2002 09:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317836AbSGKNfb>; Thu, 11 Jul 2002 09:35:31 -0400
Received: from daimi.au.dk ([130.225.16.1]:64884 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S317835AbSGKNfb>;
	Thu, 11 Jul 2002 09:35:31 -0400
Message-ID: <3D2D8A35.30F460F3@daimi.au.dk>
Date: Thu, 11 Jul 2002 15:37:57 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Lincoln Dale <ltd@cisco.com>, Linux <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
References: <E17Sd5D-0000lz-00@the-village.bc.nu>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > I'd like to see oneshot timer interrupts as a compile time
> > option on any architecture that is capable of doing it. But of
> > course it is not easy.
> >
> > Have I missed something somewhere?
> 
> The APIC on modern systems has decent timers. There may also be ACPI timers
> we can use on ACPI capable systems.

In what units do they meassure time? It would be nice if
they were garanteed to match the TSC frequency or some
other of the units already being used.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
