Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318776AbSHBLGf>; Fri, 2 Aug 2002 07:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318777AbSHBLGe>; Fri, 2 Aug 2002 07:06:34 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:21750 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318776AbSHBLGe>; Fri, 2 Aug 2002 07:06:34 -0400
Subject: Re: [PATCH] pdc20265 problem.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Orlov <nick.orlov@mail.ru>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020802014728.GA796@nikolas.hn.org>
References: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva> 
	<20020802014728.GA796@nikolas.hn.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 02 Aug 2002 13:27:25 +0100
Message-Id: <1028291245.18317.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-02 at 02:47, Nick Orlov wrote:
> 
> > <marcelo@plucky.distro.conectiva> (02/07/19 1.646)
> > 	Fix wrong #ifdef in ide-pci.c: Was causing problems with FastTrak
> 
> Because of this fix my Promise 20265 became ide0 instead of ide2.
> Is there any reason to mark pdc20265 as ON_BOARD controller?

How about because it can be and it should be checked. I don't know what
is going on with the ifdef in your case to cause this but its not as
simple as it seems

