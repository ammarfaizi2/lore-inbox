Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbVKEHPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbVKEHPU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 02:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbVKEHPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 02:15:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34735 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751309AbVKEHPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 02:15:19 -0500
Date: Fri, 4 Nov 2005 23:15:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: dtor_core@ameritech.net
Cc: dmitry.torokhov@gmail.com, drzeus-list@drzeus.cx,
       linux-kernel@vger.kernel.org, ambx1@neo.rr.com
Subject: Re: [Fwd: [PATCH] [PNP][RFC] Suspend support for PNP bus.]
Message-Id: <20051104231500.6a9272d1.akpm@osdl.org>
In-Reply-To: <d120d5000511040812g1552b610o7523b727323364d1@mail.gmail.com>
References: <436B2819.4090909@drzeus.cx>
	<d120d5000511040649u5b33405an73b5e33fb4ce5cf6@mail.gmail.com>
	<436B7B46.6060205@drzeus.cx>
	<d120d5000511040727x7d433e08jeb8937cb2e48249a@mail.gmail.com>
	<436B83D9.8@drzeus.cx>
	<d120d5000511040809m745f88a2j4a84715db3e3f01f@mail.gmail.com>
	<d120d5000511040812g1552b610o7523b727323364d1@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> On 11/4/05, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> >
> > You lost me... We have a scenario when a PNP driver is bound to a PNP
> > device that does not support deactivation. Looking at the proposed PNP
> > bus suspend code presence of such device will cause suspend process to
> > fail. Are you saying this is what you want?
> >
> 
> Ugh, scratch whatever I wrote earlier. Such devices should be marked
> with RES_DO_NOT_CHANEG so everything is fine.
> 
> Sorry about the noise.

So...  You're OK with the patch as proposed?
