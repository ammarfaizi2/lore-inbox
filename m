Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262642AbSJHBXx>; Mon, 7 Oct 2002 21:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262644AbSJHBXx>; Mon, 7 Oct 2002 21:23:53 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:52612 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S262642AbSJHBXw>;
	Mon, 7 Oct 2002 21:23:52 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200210080126.FAA14944@sex.inr.ac.ru>
Subject: Re: [PATCH] Fix IPv6
To: yoshfuji@linux-ipv6.org (YOSHIFUJI Hideaki /
	=?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?=)
Date: Tue, 8 Oct 2002 05:26:58 +0400 (MSD)
Cc: jasper@spaans.ds9a.nl, linux-kernel@vger.kernel.org
In-Reply-To: <20021008.100853.123683687.yoshfuji@linux-ipv6.org> from "YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?=" at Oct 8, 2 10:08:53 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Agreed.

Me too.

Sigh... that's why code is full of __constant_* in the most unexpected places.
For my straight brains it is much easier to use __constant_* each time when
I know forward that it is a constant instead of keeping in mind all
the gcc bugs. Well, the beast which does not eliminate empty loops,
is unlikely to eliminate if (is_constant_p()) too, right? :-) 

Alexey
