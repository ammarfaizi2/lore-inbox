Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267104AbTB0VhQ>; Thu, 27 Feb 2003 16:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267106AbTB0VhP>; Thu, 27 Feb 2003 16:37:15 -0500
Received: from packet.digeo.com ([12.110.80.53]:8580 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267104AbTB0VhP>;
	Thu, 27 Feb 2003 16:37:15 -0500
Date: Thu, 27 Feb 2003 13:44:03 -0800
From: Andrew Morton <akpm@digeo.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Rising io_load results Re: 2.5.63-mm1
Message-Id: <20030227134403.776bf2e3.akpm@digeo.com>
In-Reply-To: <200302280822.09409.kernel@kolivas.org>
References: <20030227025900.1205425a.akpm@digeo.com>
	<200302280822.09409.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Feb 2003 21:47:27.0026 (UTC) FILETIME=[D1C93920:01C2DEA9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> 
> This started some time around 2.5.62-mm3 with the io_load results on contest 
> benchmarking (http://contest.kolivas.org) rising with each run.
> ...
> Mapped:       4294923652 kB

Well that's gotta hurt.  This metric is used in making writeback decisions. 
Probably the objrmap patch.

