Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264401AbRFIREV>; Sat, 9 Jun 2001 13:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264415AbRFIREM>; Sat, 9 Jun 2001 13:04:12 -0400
Received: from firewall.ocs.com.au ([203.34.97.9]:56816 "EHLO ocs4.ocs-net")
	by vger.kernel.org with ESMTP id <S264401AbRFIRDz>;
	Sat, 9 Jun 2001 13:03:55 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: tlan@stud.ntnu.no
cc: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: missing symbol do_softirq in net moduels for pre-2 
In-Reply-To: Your message of "Sat, 09 Jun 2001 18:56:24 +0200."
             <20010609185624.A689@flodhest.stud.ntnu.no> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 10 Jun 2001 03:04:24 +1000
Message-ID: <16799.992106264@ocs4.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Jun 2001 18:56:24 +0200, 
=?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no> wrote:
>Keith Owens:
>> >Built -pre2 and noticed most of the modules in net/* are getting
>> >a missing symbol for do_softirq.  
>> http://www.tux.org/lkml/#s8-8
>
>I got the same error on -pre1, and tried the info in the link, didn't help:
>
>root@test4:/usr/src# depmod -ae
>depmod: *** Unresolved symbols in /lib/modules/2.4.6-pre1/kernel/net/ipv4/netfilter/ip_tables.o
>depmod:         do_softirq

It was missing in 6-pre1.  It should have been fixed in 6-pre2.

