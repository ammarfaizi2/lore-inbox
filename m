Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132890AbRDENIu>; Thu, 5 Apr 2001 09:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132891AbRDENIk>; Thu, 5 Apr 2001 09:08:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63887 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132890AbRDENIe> convert rfc822-to-8bit;
	Thu, 5 Apr 2001 09:08:34 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <15052.28178.701561.756926@pizda.ninka.net>
Date: Thu, 5 Apr 2001 06:07:30 -0700 (PDT)
To: =?ISO-8859-1?Q?Sarda=F1ons@pizda.ninka.net,
        ?= Eliel <Eliel.Sardanons@philips.edu.ar>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: asm/unistd.h
In-Reply-To: <A0C675E9DC2CD411A5870040053AEBA0284170@MAINSERVER>
In-Reply-To: <A0C675E9DC2CD411A5870040053AEBA0284170@MAINSERVER>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sardañons@pizda.ninka.net, Eliel writes:
 > I'm taking a look at the linux code and I don't understand how do you
 > programm...mmm (?) may be i'm a stupid why in include/asm/unistd.h in some
 > macros you use this:

Two reasons:

1) Empty statements give a warning from the compiler so
   this is why you see "#define FOO do { } while(0)"
2) It gives you a basic block in which to declare local
   variables.

Later,
David S. Miller
davem@redhat.com
