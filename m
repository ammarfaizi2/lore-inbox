Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751601AbVKDQMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbVKDQMr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 11:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbVKDQMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 11:12:47 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:44171 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751570AbVKDQMq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 11:12:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QXDMM3x7mVMF5HG/whQyYdACxBUCyCpai7lH00pz90ueI1dYqKQhgDDDP303Vm13DsYNnBtB0ExiTEnxiA6p6ouMJcUz+f+iprdAZrNdKTDZWfXF2ovGOkyASSEX7zfacOIKgAYPlxmaVbRdyAB/urOWMoUwqLe0cgG6VMdngMM=
Message-ID: <d120d5000511040812g1552b610o7523b727323364d1@mail.gmail.com>
Date: Fri, 4 Nov 2005 11:12:45 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [Fwd: [PATCH] [PNP][RFC] Suspend support for PNP bus.]
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Adam Belay <ambx1@neo.rr.com>
In-Reply-To: <d120d5000511040809m745f88a2j4a84715db3e3f01f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <436B2819.4090909@drzeus.cx>
	 <d120d5000511040649u5b33405an73b5e33fb4ce5cf6@mail.gmail.com>
	 <436B7B46.6060205@drzeus.cx>
	 <d120d5000511040727x7d433e08jeb8937cb2e48249a@mail.gmail.com>
	 <436B83D9.8@drzeus.cx>
	 <d120d5000511040809m745f88a2j4a84715db3e3f01f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/05, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> You lost me... We have a scenario when a PNP driver is bound to a PNP
> device that does not support deactivation. Looking at the proposed PNP
> bus suspend code presence of such device will cause suspend process to
> fail. Are you saying this is what you want?
>

Ugh, scratch whatever I wrote earlier. Such devices should be marked
with RES_DO_NOT_CHANEG so everything is fine.

Sorry about the noise.

--
Dmitry
