Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135724AbREFPtt>; Sun, 6 May 2001 11:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135729AbREFPtj>; Sun, 6 May 2001 11:49:39 -0400
Received: from dfmail.f-secure.com ([194.252.6.39]:17935 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S135724AbREFPtc>; Sun, 6 May 2001 11:49:32 -0400
Date: Sun, 6 May 2001 19:00:30 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Michael Miller <michaelm@mjmm.org>
cc: <linux-kernel@vger.kernel.org>, <alan@lxorguk.ukuu.org.uk>
Subject: Re: curedump configuration additions
In-Reply-To: <200105051955.f45JtAD02315@mjmm.org>
Message-ID: <Pine.LNX.4.30.0105061847570.16238-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 5 May 2001, Michael Miller wrote:

> +coredump_enabled:
> +When enabled (which is the default), Linux will produce
[...]
> +coredump_log:
> +The default is to log coredumps.

The default looks like an effective way to DoS logging, fill system
partition fast.

Nice other optional feature would be for development, debug, QA point of
view to be able to dump set[ug]id or apps that changed its uid or gid, ala
kern.sugid_coredump (FreeBSD)
kern.nosuidcoredump (OpenBSD)
allow_setid_core (Solaris)
etc.

	Szaka

