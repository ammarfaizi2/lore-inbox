Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130670AbQKPQed>; Thu, 16 Nov 2000 11:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130789AbQKPQeW>; Thu, 16 Nov 2000 11:34:22 -0500
Received: from ns.caldera.de ([212.34.180.1]:30987 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130670AbQKPQeP>;
	Thu, 16 Nov 2000 11:34:15 -0500
Date: Thu, 16 Nov 2000 17:03:54 +0100
From: Christoph Hellwig <hch@ns.caldera.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: KPATCH] Reserve VM for root (was: Re: Looking for better VM)
Message-ID: <20001116170354.A9501@caldera.de>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.30.0011161513480.20626-100000@fs129-190.f-secure.com> <Pine.LNX.4.21.0011161313310.13085-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.21.0011161313310.13085-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Thu, Nov 16, 2000 at 01:51:01PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2000 at 01:51:01PM -0200, Rik van Riel wrote:
> > If you think fork() kills the box then ulimit the maximum number
> > of user processes (ulimit -u). This is a different issue and a
> > bad design in the scheduler (see e.g. Tru64 for a better one).
> 
> My fair scheduler catches this one just fine. It hasn't
> been integrated in the kernel yet, but both VA Linux and
> Conectiva use it in their kernel RPM.

BTW: do you have a fairsched patch for 2.4?

	Christoph

-- 
Always remember that you are unique.  Just like everyone else.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
