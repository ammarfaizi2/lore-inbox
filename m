Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286935AbSAIO3T>; Wed, 9 Jan 2002 09:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286895AbSAIO27>; Wed, 9 Jan 2002 09:28:59 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:10350 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S286758AbSAIO2t>; Wed, 9 Jan 2002 09:28:49 -0500
Date: Wed, 9 Jan 2002 15:27:17 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: Robert Love <rml@tech9.net>, Daniel Phillips <phillips@bonn-fries.net>,
        Anton Blanchard <anton@samba.org>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020109152717.J1543@inspiron.school.suse.de>
In-Reply-To: <20020108030420Z287595-13997+1799@vger.kernel.org> <20020108142117.F3221@inspiron.school.suse.de> <20020108133335.GB26307@krispykreme> <E16Nxjg-00009W-00@starship.berlin> <20020108162930.E1894@inspiron.school.suse.de> <1010523340.3225.87.camel@phantasy> <20020109122418.F1543@inspiron.school.suse.de> <000a01c19917$0b567ec0$0501a8c0@psuedogod>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <000a01c19917$0b567ec0$0501a8c0@psuedogod>; from ed.sweetman@wmich.edu on Wed, Jan 09, 2002 at 09:07:55AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 09:07:55AM -0500, Ed Sweetman wrote:
> Ok so the medicine is worse than the disease.   I take it that you only want
> some key points made for rescheduling instead of the full preempt patch by
> Robert.   That seems logical enough.   The only issue i see is that for the

My ideal is to have the kernel to be as low worst latency as -preempt,
but without being preemptive. that's possible to achieve, I don't think
we're that far.

mean latency is another matter, but I personally don't mind about mean
latency and I much prefer to save cpu cycles instead.

Andrea
