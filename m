Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129763AbQLTMuj>; Wed, 20 Dec 2000 07:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129895AbQLTMu3>; Wed, 20 Dec 2000 07:50:29 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:59516 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S129763AbQLTMuW>; Wed, 20 Dec 2000 07:50:22 -0500
Date: Wed, 20 Dec 2000 14:19:45 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Matthias.Andree@stud.uni-dortmund.de
Subject: Re: [2.2.18] VM: do_try_to_free_pages failed
Message-ID: <20001220141945.F1265@niksula.cs.hut.fi>
In-Reply-To: <20001220130259.A9659@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001220130259.A9659@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Wed, Dec 20, 2000 at 01:03:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2000 at 01:03:00PM +0100, you [Matthias Andree] claimed:
> Last night, one of your production machines got wedged, I caught a lot
> of kernel: VM: do_try_to_free_pages failed for ... for a whole range of
> processes, among them ypbind, klogd, syslogd, xntpd, cron, nscd, X,
> How can I get rid of those do_try_to_free_pages lockups? That box
 
Almost everybody (including me) who have seen that problem seem to
have had it fixed with Andrea Arcangeli's VM-global-7 patch
(ftp://ftp.kernel.org/pub/linux/kernel/people/andrea...).

> Should I try the most recent 2.2.19-pre?

Yes, Andrea's VM-global-7 is included in pre2.


-- v --

v@iki.fi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
