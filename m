Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268934AbSISNbI>; Thu, 19 Sep 2002 09:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269223AbSISNbI>; Thu, 19 Sep 2002 09:31:08 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:64480 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S268934AbSISNbI>;
	Thu, 19 Sep 2002 09:31:08 -0400
To: <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Francois Romieu <romieu@cogenit.fr>, <henrique@cyclades.com>
Subject: 2.4 + generic HDLC update? Any ideas?
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 19 Sep 2002 15:32:36 +0200
Message-ID: <m3r8fqm7ez.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The question is probably aimed mainly at people maintaining 2.4 Linux
and/or networking, but I'd like to see an opinion of other users/
developers as well.

What do you think about updating the 2.4 generic HDLC layer to the
newer 2.5 code?

Facts:
- it would break all sethdlc compatibility, users would be required to
  get 2.5 sethdlc.c and recompile it. There are even cosmetic sethdlc
  syntax changes and additions (sethdlc is a configuration tool).
- it would make it possible to support new boards like Cyclades PC300
  (not only this one).
- drivers which are in current 2.4 include Moxa C101 and RISCom/N2,
  which are older ISA cards. Most of their users currently use 2.5
  generic HDLC (a patch) with 2.4 kernels anyway.
- the other driver affected is DSCC4, but I know exactly nothing about
  it (a 2.5 version of it is, of course, available). What do you think,
  Francois?

The update, if any, wouldn't take place yet. I would expect it to happen
after some remaining questions regarding 2.5 code are resolved - chances
are there will be small changes to 2.5 generic HDLC interface first.
-- 
Krzysztof Halasa
Network Administrator
