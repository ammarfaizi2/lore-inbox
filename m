Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318322AbSG3QXh>; Tue, 30 Jul 2002 12:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318328AbSG3QXg>; Tue, 30 Jul 2002 12:23:36 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:31245 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318322AbSG3QXf>; Tue, 30 Jul 2002 12:23:35 -0400
Date: Tue, 30 Jul 2002 12:21:04 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Dominik Brodowski <devel@brodo.de>
cc: davej@suse.de, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] resolve ACPI oops on boot
In-Reply-To: <20020724005518.A837@brodo.de>
Message-ID: <Pine.LNX.3.96.1020730121859.4042J-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2002, Dominik Brodowski wrote:

> The casts were probably introduced for that reason. Per se, they are not
> critical - but if there is any assumption later on that the data structure
> is indeed of the large size, there is a problem.

Perhaps the pointer chould be (void *) everywhere, and then cast to the
right size where and when it is used. Clearly casting the pointer to a
larger size will result in allignment issues on some machines.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

