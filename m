Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288811AbSBMT5z>; Wed, 13 Feb 2002 14:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288814AbSBMT5q>; Wed, 13 Feb 2002 14:57:46 -0500
Received: from courage.cs.stevens-tech.edu ([155.246.89.70]:38873 "HELO
	courage.cs.stevens-tech.edu") by vger.kernel.org with SMTP
	id <S288811AbSBMT5k>; Wed, 13 Feb 2002 14:57:40 -0500
Newsgroups: comp.os.linux.development.system
Date: Wed, 13 Feb 2002 14:57:31 -0500 (EST)
From: Marek Zawadzki <mzawadzk@cs.stevens-tech.edu>
To: <linux-kernel@vger.kernel.org>
Cc: <kernelnewbies@nl.linux.org>
Subject: Lost with UPD checksumming functions
Message-ID: <Pine.NEB.4.33.0202131443150.25958-100000@courage.cs.stevens-tech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am implementing a new transport protocol (basing on UDP
implementation) and I need to checksum every "datagram" I send
(using the same, TCP/UDP algorithm).

I am really lost in all those numerous checksumming functions in the
kernel and I'd like to know if there is any simple receipe to calculate
the checksum (I have the header, options and payload). I like the
function:

unsigned int csum_partial(const unsigned char * buff, int len, unsigned
int sum);

and I tried to call it aggainst my enitre (skb->data, skb->len, 0)
but the problem is it returns different value then the checkum calculated
by, say, UDP.
Please help.

-marek

