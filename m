Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292612AbSBPXiK>; Sat, 16 Feb 2002 18:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292613AbSBPXiA>; Sat, 16 Feb 2002 18:38:00 -0500
Received: from holomorphy.com ([216.36.33.161]:18818 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S292612AbSBPXht>;
	Sat, 16 Feb 2002 18:37:49 -0500
Date: Sat, 16 Feb 2002 15:37:39 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] shrink struct page for 2.5
Message-ID: <20020216233739.GA3511@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.33L.0202161804330.1930-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0202161804330.1930-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2002 at 06:15:03PM -0200, Rik van Riel wrote:
> Unfortunately I haven't managed to make 2.5.5-pre2 to boot on
> my machine, so I haven't been able to test this port of the
> patch to 2.5. The code has been running stably in 2.4 for the
> last 2 months though, so if you can boot 2.5, please help test
> this thing.

I tested current 2.5.5-pre bk on a diskless Pentium 200 MMX with 192MB
of RAM loading with PXELINUX and with nfsroot enabled.

The result was a triplefault (i.e. reboot) before console_init(),
which clearly isn't our code failing.

It was literally early enough I'm inclined to suspect bootloader
protocol issues.


Cheers,
Bill
