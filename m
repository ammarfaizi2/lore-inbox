Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265355AbSK1Ji6>; Thu, 28 Nov 2002 04:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265361AbSK1Ji6>; Thu, 28 Nov 2002 04:38:58 -0500
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:49414 "EHLO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with ESMTP
	id <S265355AbSK1Ji6> convert rfc822-to-8bit; Thu, 28 Nov 2002 04:38:58 -0500
Date: Thu, 28 Nov 2002 10:46:12 +0100 (CET)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PROBLEM] NFS trouble - file corruptions
In-Reply-To: <shsptsq4oy9.fsf@charged.uio.no>
Message-ID: <Pine.LNX.4.44.0211280930530.1818-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Nov 2002, Trond Myklebust wrote:

> >>>>> " " == Rasmus Bøg Hansen <moffe@amagerkollegiet.dk> writes:
>
>      > [1.] One line summary of the problem: Files created with
>      > bzip2/gzip directly to NFS file system gets corrupted
>
> Can you reproduce with 2.4.20-pre4?

I assume, you mean rc4 and not pre4?

Both client and server now running 2.4.20-rc4, but unfortunately this
does not solve the problem:

# md5sum n?.tar.bz2
6d8f530d420fb56fa590cdf1d8da9c59  n1.tar.bz2
3fa4100e6a204d1e5ad8d43d9aa9a8de  n2.tar.bz2

(both files created after reboot of both machines).

/Rasmus

-- 
-- [ Rasmus "Møffe" Bøg Hansen ] ---------------------------------------
There are three kinds of lies:
lies, politics and statistics.
----------------------------------[ moffe at amagerkollegiet dot dk ] --


