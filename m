Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267111AbSLDWFO>; Wed, 4 Dec 2002 17:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267115AbSLDWFO>; Wed, 4 Dec 2002 17:05:14 -0500
Received: from pizda.ninka.net ([216.101.162.242]:56790 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267111AbSLDWFN>;
	Wed, 4 Dec 2002 17:05:13 -0500
Date: Wed, 04 Dec 2002 14:09:54 -0800 (PST)
Message-Id: <20021204.140954.89672437.davem@redhat.com>
To: dan@debian.org
Cc: torvalds@transmeta.com, george@mvista.com, sfr@canb.auug.org.au,
       linux-kernel@vger.kernel.org, anton@samba.org, ak@muc.de,
       davidm@hpl.hp.com, schwidefsky@de.ibm.com, ralf@gnu.org,
       willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021204205609.GA29953@nevyn.them.org>
References: <3DEE5DE1.762699E3@mvista.com>
	<Pine.LNX.4.44.0212041203230.1676-100000@penguin.transmeta.com>
	<20021204205609.GA29953@nevyn.them.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Daniel Jacobowitz <dan@debian.org>
   Date: Wed, 4 Dec 2002 15:56:09 -0500
   
   Is the necessary information recoverable in
   Alpha et al.?

No, and Sparc is the same.  It's kept in local registers
in the assembler of the trap return path.

