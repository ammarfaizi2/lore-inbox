Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267376AbUJNTgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267376AbUJNTgG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 15:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267368AbUJNTcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 15:32:36 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:55160 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267397AbUJNTb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 15:31:56 -0400
Message-ID: <58cb370e04101412312fc42a57@mail.gmail.com>
Date: Thu, 14 Oct 2004 21:31:54 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Ian Pilcher <i.pilcher@comcast.net>
Subject: Re: ATA/133 Problems with multiple cards
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
In-Reply-To: <ckmfiq$rc7$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.44.0410141710390.1681-100000@beast.stev.org>
	 <ckmfiq$rc7$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004 13:12:42 -0500, Ian Pilcher <i.pilcher@comcast.net> wrote:
> James Stevenson wrote:
> >
> > i seem to have run into an annoying problem with a machine which has
> > 3 promise ata/133 card the PDC20269 type.
> >
> 
> ....
> 
> >
> > Does anyone have an explenation of why this can happen ?

* check power supply
* compare PCI config space of the "failing" controller to the one which
  is "working" (assuming that identical devices are connected to each),
  maybe firmware/driver forgets to setup some settings

> Promise cards don't support more than two per machine.  If you can get a
> third card to work in PIO mode, consider it an added (but unsupported)
> bonus.

AFAIR people have been running 4-5 cards just fine
