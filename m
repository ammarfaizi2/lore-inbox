Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSC0CyT>; Tue, 26 Mar 2002 21:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312974AbSC0CyJ>; Tue, 26 Mar 2002 21:54:09 -0500
Received: from are.twiddle.net ([64.81.246.98]:657 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S312973AbSC0Cx6>;
	Tue, 26 Mar 2002 21:53:58 -0500
Date: Tue, 26 Mar 2002 18:53:56 -0800
From: Richard Henderson <rth@twiddle.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 7.52 second kernel compile
Message-ID: <20020326185356.B19912@twiddle.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0203181146070.4783-100000@home.transmeta.com> <Pine.LNX.4.33.0203181213130.12950-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the record, Alpha timings:

pca164 @ 533MHz:
  72.79: 19
   1.50: 20
  21.30: 35
   1.50: 36
   1.30: 105

ev6 @ 500MHz:
   2.43: 78
  72.13: 84
   2.55: 89
   5.87: 90
   1.38: 105
   5.94: 108
   1.36: 112

I wonder how much of that ev6 slowdown is due to an SRM that's
has to handle both 3 and 4 level page tables, and how much is
due to the more expensive syncing of the OOO pipeline...


r~
