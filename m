Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277082AbRJQT2G>; Wed, 17 Oct 2001 15:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277085AbRJQT14>; Wed, 17 Oct 2001 15:27:56 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:25875 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S277082AbRJQT1o>;
	Wed, 17 Oct 2001 15:27:44 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200110171927.XAA22869@ms2.inr.ac.ru>
Subject: Re: [NFS] NFSD over TCP: TCP broken?
To: kalele@veritas.com (Shirish Kalele)
Date: Wed, 17 Oct 2001 23:27:54 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org, tamir@veritas.com, paulp@veritas.com
In-Reply-To: <00b401c157a1$8edd3f20$3291b40a@fserv2000.net> from "Shirish Kalele" at Oct 17, 1 11:53:14 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>        through the underlying protocol,  the  error  EMSGSIZE  is
>        returned, and the message is not transmitted.

It is about datagram sockets, stream sockets never return EMSGSIZE,
because have no messages boundaries.

Alexey
