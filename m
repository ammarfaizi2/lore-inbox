Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315372AbSHIRlY>; Fri, 9 Aug 2002 13:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315374AbSHIRlY>; Fri, 9 Aug 2002 13:41:24 -0400
Received: from 62-190-217-11.pdu.pipex.net ([62.190.217.11]:32772 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S315372AbSHIRlX>; Fri, 9 Aug 2002 13:41:23 -0400
From: jbradford@dial.pipex.com
Message-Id: <200208091751.g79HpYZr000357@darkstar.example.net>
Subject: Re: No reset of IDE disk
To: diegocg@teleline.es (Arador)
Date: Fri, 9 Aug 2002 18:51:34 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020809193933.275df7a5.diegocg@teleline.es> from "Arador" at Aug 09, 2002 07:39:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is because you *have* to use -w after -Y. The "sleep" method you're
> searching is -y, not -Y (dont ask me why.... ;)

Are you absolutely sure?  My laptop, (same software versions), wakes up the hard disk successfully after a -Y sleep, (although on 2.2.13 it used to generate a spurious interupt message first).

Also, from the hdparm MAN page, it says "A hard or soft reset is  required before  the  drive can be accessed again (the Linux IDE driver will automatically handle issuing a reset if/when needed).

A -y standby achieves the expected behaviour, (I.E. automatic spin up), with no errors.
