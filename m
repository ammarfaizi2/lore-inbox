Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131387AbRCWTtB>; Fri, 23 Mar 2001 14:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131393AbRCWTsw>; Fri, 23 Mar 2001 14:48:52 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:38417 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S131387AbRCWTsm>; Fri, 23 Mar 2001 14:48:42 -0500
Date: Fri, 23 Mar 2001 21:57:20 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Guest section DW <dwguest@win.tue.nl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Stephen Clouse <stephenc@theiqgroup.com>,
        Rik van Riel <riel@conectiva.com.br>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <20010322230041.A5598@win.tue.nl>
Message-ID: <Pine.LNX.4.30.0103232135020.13864-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Mar 2001, Guest section DW wrote:
> Presently however, a flawless program can be killed.
> That is what makes Linux unreliable.

Your advocation is "save the application, crash the OS!". But you can't
be blamed because everybody's first reaction is this :) But if you start
to think you get the conclusion that process killing can't be avoided if
you want the system keep running. But I agree Linux lacks some important
things [see my other email] that could make the situation easily and
inexpensively controllable.

BTW, your app isn't flawless because it doesn't consider Linux memory
management is [quasi-]overcommit-only at present ;) [or you used other
apps as well, e.g. login, ps, cron is enough to kill your app when it
stopped at OOM time].

	Szaka

