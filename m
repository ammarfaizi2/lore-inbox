Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271970AbTGYJCd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 05:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271971AbTGYJCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 05:02:33 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1664 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S271970AbTGYJCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 05:02:32 -0400
Date: Fri, 25 Jul 2003 10:27:41 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307250927.h6P9Rf9P000127@81-2-122-30.bradfords.org.uk>
To: cs@tequila.co.jp, ndiamond@wta.att.ne.jp
Subject: Re: Japanese keyboards broken in 2.6
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> cheap, but working and I think it will stay so until 2.6 goes into final
> of distris:
>
> setkeycodes 0x6a 124 1>&2 in your rc.local, local.start or whatever.
> works fine for me for alle 2.5x kernels

Is your keyboard detected as a set2 or set3 keyboard?

Mine is detected as set2, but will also work in set3.  When I get
chance, I'll make a patch to detect it and set set3 automatically.

In the default set2 it emulates a US keyboard - pressing : for
example, generates the make codes for shift, and ;, then the break
codes.  The keys beside the spacebar produce the spacebar make and
break codes, and cannot be used independantly in set2.

I'm curious as to whether set3 is generally supported by Japanese
keyboards, or not, even if they are not detected as set3.

John.
