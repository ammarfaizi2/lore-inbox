Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267548AbTB1G6x>; Fri, 28 Feb 2003 01:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267559AbTB1G6x>; Fri, 28 Feb 2003 01:58:53 -0500
Received: from elixir.e.kth.se ([130.237.48.5]:60939 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S267548AbTB1G6w>;
	Fri, 28 Feb 2003 01:58:52 -0500
To: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Cc: linux-kernel@vger.kernel.org
Subject: Re: hpt374 misbehaving
References: <yw1xd6ldw734.fsf@zaphod.guide>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 28 Feb 2003 08:08:57 +0100
In-Reply-To: mru@users.sourceforge.net's message of "28 Feb 2003 02:02:23 +0100"
Message-ID: <yw1xvfz4dgqe.fsf@manganonaujakasit.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@users.sourceforge.net (Måns Rullgård) writes:

> I'm having some trouble with an hpt374 based card, the S-ATA version.
> The chip is detected correctly, but after that the problems start.
> 
> hde: lost interrupt

A though just struck me.  Could this be caused by the config option
"IDE IRQ sharing" being unset?  I don't remember if I set it, I'll
have to check at home.  The hpt374 is really two logical devices in a
single chip, isn't it?

-- 
Måns Rullgård
mru@users.sf.net
