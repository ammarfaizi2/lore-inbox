Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315213AbSFCOF5>; Mon, 3 Jun 2002 10:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315300AbSFCOF4>; Mon, 3 Jun 2002 10:05:56 -0400
Received: from pg-fw.paradigmgeo.com ([192.117.235.33]:45762 "EHLO
	ntserver2.geodepth.com") by vger.kernel.org with ESMTP
	id <S315213AbSFCOF4>; Mon, 3 Jun 2002 10:05:56 -0400
Message-ID: <EE83E551E08D1D43AD52D50B9F5110927E7A10@ntserver2>
From: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
To: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Atomic operations
Date: Mon, 3 Jun 2002 17:04:20 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I wonder if someone can help me to change the behaviour of the atomic
functions available in <asm/atomic.h> include file. The operations I need to
implement are described below:

atomic_t test_and_set (int i, atomic_t* v)
{
   atomic_t old = *v;
   v->counter = i;
   return old;
}

atomic_t test_then_add (int i, atomic_t* v)
{
   atomic_t old = *v;
   v->counter += i;
   return old;
}

Thanks in advance,
Giga

