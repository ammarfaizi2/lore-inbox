Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261501AbSIWWDz>; Mon, 23 Sep 2002 18:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261511AbSIWWDz>; Mon, 23 Sep 2002 18:03:55 -0400
Received: from vti01.vertis.nl ([145.66.4.26]:14085 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S261501AbSIWWDy>;
	Mon, 23 Sep 2002 18:03:54 -0400
Message-Id: <200209232208.g8NM8bN05831@fokkensr.vertis.nl>
Content-Type: text/plain; charset=US-ASCII
From: Rolf Fokkens <fokkensr@fokkensr.vertis.nl>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH] 32bit wraps and USER_HZ [64 bit counters], kernel 2.5.37
Date: Tue, 24 Sep 2002 00:08:16 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
References: <200209222207.g8MM7MM04998@fokkensr.vertis.nl> <20020923023655.GV3530@holomorphy.com>
In-Reply-To: <20020923023655.GV3530@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 September 2002 04:36, William Lee Irwin III wrote:
> -	unsigned long utime, stime, cutime, cstime;
> -	unsigned long start_time;
> -	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
>
> Hmm. Isn't task_t bloated enough already? I'd rather remove them than
> make them 64-bit.

Since nobody else asks this question:

Do you mean to leave out process statistics?
