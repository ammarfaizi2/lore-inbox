Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282547AbRLWRze>; Sun, 23 Dec 2001 12:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282799AbRLWRzX>; Sun, 23 Dec 2001 12:55:23 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:150 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S282547AbRLWRzH>; Sun, 23 Dec 2001 12:55:07 -0500
Date: Sun, 23 Dec 2001 09:55:01 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: LKML <linux-kernel@vger.kernel.org>
cc: Jim Radford <radford@blackbean.org>, Adam Keys <akeys@post.cis.smu.edu>
Subject: Re: IDE Harddrive Performance
Message-ID: <Pine.LNX.4.33.0112230942030.19818-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jim and Adam,

I recommend that you check out the smartsuite package described in
http://www.linux-ide.org/smart.html.  It showed me that when a Maxtor
drive I recently purchased dropped from 40MB/sec to 1MB/sec throughput, it
was having an incredible number of "Hardware ECC Recovered" (SMART
attribute 195) events.  I guess some bit chunk of the magnetic media had
failed, in a way that still allowed the drive to recover all the data, but
so that the overhead of the requisite ECC was killing the throughput.  I
ended up returning it for a replacement.

Cheers, Wayne



