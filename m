Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284793AbRLMSxU>; Thu, 13 Dec 2001 13:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284813AbRLMSxK>; Thu, 13 Dec 2001 13:53:10 -0500
Received: from vitelus.com ([64.81.243.207]:30729 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S284793AbRLMSw4>;
	Thu, 13 Dec 2001 13:52:56 -0500
Date: Thu, 13 Dec 2001 10:52:53 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Rene Rebe <rene.rebe@gmx.net>
Cc: linux-kernel@vger.kernel.org, hfhsu@sis.com.tw, lcchang@sis.com.tw
Subject: Re: Disappointing SiS900 performance - driver issue?
Message-ID: <20011213105253.A14819@vitelus.com>
In-Reply-To: <20011213102423.B13809@vitelus.com> <20011213194555.50d6adeb.rene.rebe@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011213194555.50d6adeb.rene.rebe@gmx.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hrm.

I get similar results.

On Thu, Dec 13, 2001 at 07:45:55PM +0100, Rene Rebe wrote:
> TCP/IP connection established.
> Packet size  1 k bytes:   10259 k bytes/sec
> Packet size  2 k bytes:   10146 k bytes/sec
> Packet size  4 k bytes:   10288 k bytes/sec
> Packet size  8 k bytes:   10317 k bytes/sec
> Packet size 16 k bytes:   10248 k bytes/sec
> Packet size 32 k bytes:   10173 k bytes/sec

[aaronl@endquote:~]$ ./netio 192.168.2.1

NETIO - Network Throughput Benchmark, Version 1.13
(C) 1997-2001 Kai Uwe Rommel

TCP/IP connection established.
Packet size  1 k bytes:   10102 k bytes/sec
Packet size  2 k bytes:   9460 k bytes/sec
Packet size  4 k bytes:   10129 k bytes/sec
Packet size  8 k bytes:   9912 k bytes/sec
Packet size 16 k bytes:   10112 k bytes/sec
Packet size 32 k bytes:   9773 k bytes/sec

But it doesn't live up to this on HTTP or FTP.

10:52:03 (3.64 MB/s) - `/dev/null' saved [4663650/4663650]
10:52:13 (4.19 MB/s) - `/dev/null' saved [4663650/4663650]
10:52:16 (3.99 MB/s) - `/dev/null' saved [4663650/4663650]

