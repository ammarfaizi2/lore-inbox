Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317340AbSGOFn6>; Mon, 15 Jul 2002 01:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317341AbSGOFn5>; Mon, 15 Jul 2002 01:43:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:13507 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317340AbSGOFn4>;
	Mon, 15 Jul 2002 01:43:56 -0400
Date: Sun, 14 Jul 2002 22:37:33 -0700 (PDT)
Message-Id: <20020714.223733.74734758.davem@redhat.com>
To: ak@suse.de
Cc: dean-list-linux-kernel@arctic.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG?] unwanted proxy arp in 2.4.19-pre10
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <p73lm8eup9k.fsf@oldwotan.suse.de>
References: <20020713.205930.101495830.davem@redhat.com.suse.lists.linux.kernel>
	<Pine.LNX.4.44.0207141026440.4252-100000@twinlark.arctic.org.suse.lists.linux.kernel>
	<p73lm8eup9k.fsf@oldwotan.suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: 14 Jul 2002 20:40:23 +0200
   
   Another thing that was implemented is a netfilter chain for ARP, but
   afaik there are no filtering modules for it yet, so Joe User cannot
   use it. It likely just exists somewhere as a proprietary module in
   someone's firewall appliance and all they did was to contribute the
   hook. It probably would not be hard to rewrite a filter module for it,
   but again nobody did it yet.

I wrote the kernel bits but never got around to coding up the
netfilter user tools.  Assuming, just because of lacking userland
tools, it was for some "proprietary firewall appliance" is pretty
damn rude.  You could have at least looked at who the author was
and asked him (ie. me). :(
