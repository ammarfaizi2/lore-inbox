Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbTL3UrD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 15:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbTL3UrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 15:47:03 -0500
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:10206 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S262355AbTL3UrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 15:47:01 -0500
Date: Tue, 30 Dec 2003 13:48:20 -0700
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Is it safe to ignore UDMA BadCRC errors?
Message-ID: <20031230204820.GA7663@bounceswoosh.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <16368.20794.147453.255239@jik.kamens.brookline.ma.us> <20031229195235.GC26821@bounceswoosh.org> <16369.25514.425834.153361@jik.kamens.brookline.ma.us> <20031230200643.GC6992@bounceswoosh.org> <16369.56307.995425.595117@jik.kamens.brookline.ma.us> <20031230202540.GE6992@bounceswoosh.org> <16369.57428.470813.237725@jik.kamens.brookline.ma.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <16369.57428.470813.237725@jik.kamens.brookline.ma.us>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30 at 15:30, Jonathan Kamens wrote:
>Eric D. Mudama writes:
> > UDMA modes include a checksum on every transfer, for both reads and
> > writes.
>
>This contradicts what I was told previously by another subscriber to
>this list.
>
>If it is true, then it would appear that the answer to my question "Is
>it save to ignore UDMA BadCRC errors?" is "Yes."  If all transfers are
>checksummed, and if all transfers with bad checksums will be retried
>by the kernel, then occasional checksum errors are harmless because
>they will be retried.  Do you agree?

No, I don't.

Your system may always detect the errors and function happily (as
designed) but to me the $30 for the security of knowing you have 100%
functioning hardware is well worth it.

--eric

-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

