Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264940AbTCDWuI>; Tue, 4 Mar 2003 17:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265270AbTCDWuI>; Tue, 4 Mar 2003 17:50:08 -0500
Received: from sex.inr.ac.ru ([193.233.7.165]:30602 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S264940AbTCDWtu>;
	Tue, 4 Mar 2003 17:49:50 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200303042259.BAA06142@sex.inr.ac.ru>
Subject: Re: PCI init issues
To: ink@jurassic.park.msu.ru (Ivan Kokshaysky)
Date: Wed, 5 Mar 2003 01:59:33 +0300 (MSK)
Cc: becker@scyld.com, ink@jurassic.park.msu.ru, hadi@cyberus.ca,
       greg@kroah.com, torvalds@transmeta.com, jgarzik@pobox.com,
       kuznet@ms2.inr.ac.ru, david.knierim@tekelec.com,
       Robert.Olsson@data.slu.se, linux-kernel@vger.kernel.org,
       alexander@netintact.se
In-Reply-To: <20030305013037.A678@localhost.park.msu.ru> from "Ivan Kokshaysky" at Mar 5, 3 01:30:37 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I know for a fact that at least D-Link card mentioned in some reports
> utilizes all four INT# lines, because I have one.

I confirm, my Znyx card (pci subsys 110d:0029) is wired correctly to INTA/B/C/D
and works nicely with plain flat motherboards.

Look at Jamal's mail: the cards work well when attached to primary
bus. They stop to work when connected via one more bridge (which is
common for server motherboards).

Alexey
