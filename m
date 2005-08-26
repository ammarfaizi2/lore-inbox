Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbVHZGt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbVHZGt1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 02:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVHZGt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 02:49:27 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:52914 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S932535AbVHZGt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 02:49:26 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Patrick Draper <pdraper@gmail.com>
Subject: Re: VIA Rhine ethernet driver bug (reprise...)
Date: Fri, 26 Aug 2005 09:33:45 +0300
User-Agent: KMail/1.8.2
Cc: Udo van den Heuvel <udovdh@xs4all.nl>, linux-kernel@vger.kernel.org
References: <430A0B69.1060304@xs4all.nl> <200508231221.59299.vda@ilport.com.ua> <6981e08b0508252043139cfa2d@mail.gmail.com>
In-Reply-To: <6981e08b0508252043139cfa2d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508260933.45402.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 August 2005 06:43, Patrick Draper wrote:
> On 8/23/05, Denis Vlasenko <vda@ilport.com.ua> wrote:
> > >Since it happens less than once a day, why not just add a code
> > >to reset the NIC completely in this case, like it is
> > >typically done in tx_timeout handlers of many NICs, and forget about it?
> >
> > Do you see any problems in this approach?
>
> I've refrained from posting here because my hardware is currently in the
> closet, so I can't help too much. I had problems with Rhine on my ME6000
> (VIA Mini-ITX) board. I tried to reset the NIC by unloading kernel modules
> and reloading them, and reinitializing the network, and that didn't work
> for me. The problem was triggered by merely unplugging the ethernet cable.
> When it was plugged back in, the network was gone and only a reboot would
> bring it back.
>
> Sorry I can't file a better bug report, but I won't be able to until
> November at the earliest. But I thought you should know that at least one
> person can't use the approach of resetting the NIC.

May be a known problem. A buglet in MII common code.
Via-rhine maintainer knows about it, as does Jeff.
--
vda
