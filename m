Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266728AbSLPNPw>; Mon, 16 Dec 2002 08:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266730AbSLPNPw>; Mon, 16 Dec 2002 08:15:52 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:21004 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S266728AbSLPNPw>; Mon, 16 Dec 2002 08:15:52 -0500
Message-Id: <200212161317.gBGDHIs12671@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.51 load avg += 1
Date: Mon, 16 Dec 2002 16:06:38 -0200
X-Mailer: KMail [version 1.3.2]
References: <200212141817.21202.roy@karlsbakk.net>
In-Reply-To: <200212141817.21202.roy@karlsbakk.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 December 2002 15:17, Roy Sigurd Karlsbakk wrote:
> hi
>
> running 2.5.51, when I run 'uptime', it shows my uptime+1. that means
> if my system is idle, as it usually is, load avg is 1.0 1.0 1.0.
> starting my fabolous test program main(){for(;;);}, the load avg
> climbs up to 2.0. .config is below
>
> roy

I'd say you have a zombie or 'D' hung process. Can we see your top/ps output?
--
vda
