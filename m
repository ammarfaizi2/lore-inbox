Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261876AbSI3AYb>; Sun, 29 Sep 2002 20:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261877AbSI3AYb>; Sun, 29 Sep 2002 20:24:31 -0400
Received: from pizda.ninka.net ([216.101.162.242]:7083 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261876AbSI3AYa>;
	Sun, 29 Sep 2002 20:24:30 -0400
Date: Sun, 29 Sep 2002 17:22:54 -0700 (PDT)
Message-Id: <20020929.172254.42500513.davem@redhat.com>
To: arjanv@fenrus.demon.nl
Cc: perex@suse.cz, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA update [6/10] - 2002/07/20
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1033326744.2419.9.camel@localhost.localdomain>
References: <Pine.LNX.4.33.0209292050390.591-100000@pnote.perex-int.cz>
	<1033326744.2419.9.camel@localhost.localdomain>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arjan van de Ven <arjanv@fenrus.demon.nl>
   Date: 29 Sep 2002 21:12:23 +0200
   
   what is wrong with the PCI DMA API that makes ALSA wants a private
   interface/implementation ?

It makes the layers not have to know what the BUS is, and this can all
be deleted when everything goes through a generic struct device and
assosciated OPS.

I think ALSA is definitely doing the right thing here.
