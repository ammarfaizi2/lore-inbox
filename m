Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266120AbUGJDLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266120AbUGJDLE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 23:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266117AbUGJDLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 23:11:03 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:55522 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266115AbUGJDK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 23:10:58 -0400
Message-ID: <40EF5E3F.90401@comcast.net>
Date: Fri, 09 Jul 2004 23:10:55 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040630)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org,
       linux-c-programming <linux-c-programming@vger.kernel.org>
Subject: Re: Garbage Collection and Swap
References: <40EF3BCD.7080808@comcast.net> <20040710023245.GE21066@holomorphy.com>
In-Reply-To: <20040710023245.GE21066@holomorphy.com>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



William Lee Irwin III wrote:
| On Fri, Jul 09, 2004 at 08:43:57PM -0400, John Richard Moser wrote:
|
|>Read that.  It's in all caps, so you should read it.  It has meaning.
|>How about, everything is using Bohem GC.  Bohem wanders around in the
|>heap concurrently.  So all of your applications are wandering around
|>through their vm space everywhere, continuously.
|>You get low on ram.  Let's say an app is using 500M of ram (Mozilla).
|>What's going to happen?  Obvious.  It's going to yank shit out of swap.
|>If we all linked against a GC, what kinds of swap hell do you think we'd
|>encounter?
|
|
| Ones almost as bad as the Hell of trolls going nuts over hypothetical
| problems no one is stupid enough to cause in practice anyway.
|
|

I'm actually trying to get the boehm one up, but it keeps setting PaX
off for some odd reason.  I'd intended to have some test data right
about now. . . . >/  Firefox, gimp, hell vim can't run with boehm
LD_PRELOAD to redirect malloc().  Nano can.  A simple tester can.
fortune can't.  BASH doesn't seem to like it.

It's only hypothetical until I prove or disprove it; and I'm not afraid
to do either.

| -- wli
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA7145hDd4aOud5P8RAkTCAJ9onJMZS5bFzu8ppfvyWg8vOE5SzQCeL5SR
NZPBU5gMs/ZSl0iXuJmvnYQ=
=UVWv
-----END PGP SIGNATURE-----
