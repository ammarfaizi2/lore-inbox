Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319297AbSHVDb4>; Wed, 21 Aug 2002 23:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319298AbSHVDb4>; Wed, 21 Aug 2002 23:31:56 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:45836 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S319297AbSHVDb4>; Wed, 21 Aug 2002 23:31:56 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Problem with random.c and PPC
Date: 22 Aug 2002 03:19:40 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <ak1l8c$drl$2@abraham.cs.berkeley.edu>
References: <80256C17.00376E92.00@notesmta.eur.3com.com> <20020816195254.GL5418@waste.org> <3D5D6621.E33EA4BE@nortelnetworks.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1029986380 14197 128.32.153.211 (22 Aug 2002 03:19:40 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 22 Aug 2002 03:19:40 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen  wrote:
>The problem is this.  If you have an embedded system that is headless,
>diskless, keyboardless, and
>mouseless, then your only remaining source of any interrupt-based
>entropy is the network.

Try replacing "network" with "/dev/zero" to see how your sentence
sounds, and then maybe the flaw in your reasoning will become apparent.

  "If you have an embedded system that is headless, etc., then your
  only remaining source of entropy is /dev/zero."

Well, sometimes there is just no reliable entropy source on hand.
Maybe it's better to admit that than to fool ourselves.
