Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSDOQrY>; Mon, 15 Apr 2002 12:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312975AbSDOQrX>; Mon, 15 Apr 2002 12:47:23 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:24078 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S312973AbSDOQrX>; Mon, 15 Apr 2002 12:47:23 -0400
Date: Mon, 15 Apr 2002 18:47:15 +0200 (CEST)
From: tomas szepe <kala@pinerecords.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7 keyboard problem
Message-ID: <Pine.LNX.4.44.0204151839560.6489-100000@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I saw that already,
> Here is a snippet from my .config

Jup, I've got to confirm this: PS/2 keyboards won't work on my
VIA KT133A-based board on both 2.5.8 vanilla and -dj2/3.
(no, not even IBM Model M. :D)

an excerpt from the 2.5.8 .config in question:
.
.
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=y
CONFIG_INPUT_MOUSEDEV=y
.
.
CONFIG_SERIO=y
CONFIG_SERIO_SERPORT=y
.


t.

pub 1024d/8e316a84 2002-01-29   tomas szepe <kala@pinerecords.com>
openpgp f/print 2955 2eea c4b8 b09e 7ae1  4d5d 68e3 d606 8e31 6a84

