Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292131AbSBYXLF>; Mon, 25 Feb 2002 18:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292394AbSBYXKz>; Mon, 25 Feb 2002 18:10:55 -0500
Received: from pizda.ninka.net ([216.101.162.242]:58529 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S292131AbSBYXKp>;
	Mon, 25 Feb 2002 18:10:45 -0500
Date: Mon, 25 Feb 2002 15:08:13 -0800 (PST)
Message-Id: <20020225.150813.66161624.davem@redhat.com>
To: matthias.andree@stud.uni-dortmund.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020225230156.GA11786@merlin.emma.line.org>
In-Reply-To: <20020225.140851.31656207.davem@redhat.com>
	<3C7AB893.4090800@ellinger.de>
	<20020225230156.GA11786@merlin.emma.line.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
   Date: Tue, 26 Feb 2002 00:01:56 +0100

   > And how should EXTRAVERSION be accommodated?
   
   sed/perl/awk -- a short five-liner "bless-rc-to-final" script should do.

Ummm... no.

This whole conversation exists because "Deleting the EXTRAVERSION
setting from linux/Makefile" then making new diffs/tars was screwed
up.  Doing it with a script isn't going to help this kind of problem.

I repeat: it isn't a "release candidate" if it will not match preciely
what the final tarball/patches contains.  Anything else opens up the
possibility for errors to be made.
