Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266041AbTA2OPs>; Wed, 29 Jan 2003 09:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266064AbTA2OPs>; Wed, 29 Jan 2003 09:15:48 -0500
Received: from sex.inr.ac.ru ([193.233.7.165]:6053 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S266041AbTA2OPs>;
	Wed, 29 Jan 2003 09:15:48 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200301291424.RAA32107@sex.inr.ac.ru>
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x,
To: lkernel2003@tuxers.net (David C Niemi)
Date: Wed, 29 Jan 2003 17:24:52 +0300 (MSK)
Cc: davem@redhat.com, benoit-lists@fb12.de, dada1@cosmosbay.com,
       cgf@redhat.com, andersg@0x63.nu, lkernel2003@tuxers.net,
       linux-kernel@vger.kernel.org, tobi@tobi.nu
In-Reply-To: <Pine.LNX.4.44.0301290904060.7848-100000@harappa.oldtrail.reston.va.us> from "David C Niemi" at Jan 29, 3 09:12:54 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Odd, then, that it I was unable to reproduce the SSH hangs under 2.4.18

The bug is there, but it cannot be triggered with ssh.
In 2.4 it can happen only on sockets which use sendfile().

Alexey

