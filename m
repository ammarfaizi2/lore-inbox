Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318093AbSFTCHq>; Wed, 19 Jun 2002 22:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318095AbSFTCHp>; Wed, 19 Jun 2002 22:07:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10162 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318093AbSFTCHo>;
	Wed, 19 Jun 2002 22:07:44 -0400
Date: Wed, 19 Jun 2002 19:01:47 -0700 (PDT)
Message-Id: <20020619.190147.38450820.davem@redhat.com>
To: rml@tech9.net
Cc: george@mvista.com, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace timer_bh with tasklet
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1024538711.921.85.camel@sinai>
References: <1024538005.922.70.camel@sinai>
	<20020619.185514.52961715.davem@redhat.com>
	<1024538711.921.85.camel@sinai>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Robert Love <rml@tech9.net>
   Date: 19 Jun 2002 19:05:11 -0700

   On Wed, 2002-06-19 at 18:55, David S. Miller wrote:
   
   > What about all of the serial driver BHs?  You keep avoiding this
   > issue.
   
   Because I was told rmk's serial rewrite ditched old-style BHs...

That isn't in the tree now.  We can only make analsis of the patch
based upon what is in 2.5.x right now, you can't base it on what
might be added in the future.
