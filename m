Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271993AbRIDQhg>; Tue, 4 Sep 2001 12:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271994AbRIDQh3>; Tue, 4 Sep 2001 12:37:29 -0400
Received: from are.twiddle.net ([64.81.246.98]:25477 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S271993AbRIDQhS>;
	Tue, 4 Sep 2001 12:37:18 -0400
Date: Tue, 4 Sep 2001 09:37:25 -0700
From: Richard Henderson <rth@twiddle.net>
To: David Mosberger <davidm@hpl.hp.com>
Cc: Paul Mackerras <paulus@samba.org>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [PATCH] avoid unnecessary cache flushes
Message-ID: <20010904093725.A18163@twiddle.net>
Mail-Followup-To: David Mosberger <davidm@hpl.hp.com>,
	Paul Mackerras <paulus@samba.org>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <15247.29338.3671.548678@cargo.ozlabs.ibm.com> <20010903131436.A16069@twiddle.net> <15251.59286.154267.431231@napali.hpl.hp.com> <20010903134125.B16069@twiddle.net> <15251.61303.411698.310497@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15251.61303.411698.310497@napali.hpl.hp.com>; from davidm@hpl.hp.com on Mon, Sep 03, 2001 at 02:00:39PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2001 at 02:00:39PM -0700, David Mosberger wrote:
> I didn't think there was any path where the kernel would on its own
> update code after the fact, but I could be missing something.

ptrace?


r~
