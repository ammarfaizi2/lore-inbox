Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318101AbSFTC3l>; Wed, 19 Jun 2002 22:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318102AbSFTC3k>; Wed, 19 Jun 2002 22:29:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:27314 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318101AbSFTC3k>;
	Wed, 19 Jun 2002 22:29:40 -0400
Date: Wed, 19 Jun 2002 19:23:42 -0700 (PDT)
Message-Id: <20020619.192342.128398093.davem@redhat.com>
To: rml@tech9.net
Cc: george@mvista.com, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace timer_bh with tasklet
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1024539334.917.110.camel@sinai>
References: <1024538711.921.85.camel@sinai>
	<20020619.190147.38450820.davem@redhat.com>
	<1024539334.917.110.camel@sinai>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Robert Love <rml@tech9.net>
   Date: 19 Jun 2002 19:15:34 -0700

   Could there possibly be any interaction between SERIAL_BH and TIMER_BH?
   
Or the drivers... these are the questions that must be answered before
we can consider the patch.

Also the TIMER_BH patch has to attend to the deliver_to_old_ones issue
before it may be considered further.
