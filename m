Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279818AbRKIL3r>; Fri, 9 Nov 2001 06:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279824AbRKIL3i>; Fri, 9 Nov 2001 06:29:38 -0500
Received: from [213.96.124.18] ([213.96.124.18]:9707 "HELO dardhal")
	by vger.kernel.org with SMTP id <S279818AbRKIL3X>;
	Fri, 9 Nov 2001 06:29:23 -0500
Date: Fri, 9 Nov 2001 12:29:44 +0000
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@internautas.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: bonding driver - linux kernel
Message-ID: <20011109122944.A1138@dardhal.mired.net>
Mail-Followup-To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1005299191.5985.32.camel@praetorian>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1005299191.5985.32.camel@praetorian>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 09 November 2001, at 04:46:31 -0500,
Phil Sorber wrote:

> hello,
> 
> i have an HP Procurve 4000M and a linux box with an Intel Pro/100 Dual
> Port Server Adapter (eepro.c). we have the switch set to do cicso
> etherchannel, which the procurve supports. but it seems not to work in
> this mode. we have to back down to trunking mode, giving us 200Mbit
> upstream, but only 100Mbit down stream.
> 
Don't know what the problem can be, but as you seem interested in the
code, apart from the bonding driver in official kernels, there an
alternative (and more featureful) implementation here:
http://sf.net/projects/bonding/

It is a patch against recent 2.4.x kernels (lat 2.4.13). Apart from
traditional bonding/trunking (two or more cards give you aggregated
bandwith) it implements "link failover". Give it a try :)

-- 
José Luis Domingo López
Linux Registered User #189436     Debian Linux Woody (P166 64 MB RAM)
 
jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
jdomingo AT internautas DOT   org  => Spam at your own risk

