Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289024AbSAFUYS>; Sun, 6 Jan 2002 15:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289025AbSAFUX6>; Sun, 6 Jan 2002 15:23:58 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:56193 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S289024AbSAFUXs>; Sun, 6 Jan 2002 15:23:48 -0500
Date: Sun, 6 Jan 2002 15:23:47 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Gerrit Huizenga <gerrit@us.ibm.com>,
        "M. Edward Borasky" <znmeb@aracnet.com>,
        Harald Holzer <harald.holzer@eunet.at>, linux-kernel@vger.kernel.org
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
Message-ID: <20020106152347.E27926@redhat.com>
In-Reply-To: <20020106032030.A27926@redhat.com> <E16NFxv-0005e4-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16NFxv-0005e4-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Jan 06, 2002 at 04:16:07PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2002 at 04:16:07PM +0000, Alan Cox wrote:
> You don't neccessarily need PSE. Migrating to an option to support > 4K
> _virtual_ page size is more flexible for x86, although it would need 
> glibc getpagesize() fixing I think, and might mean a few apps wouldnt
> run in that configuration.

Perhaps, but if the majority of people using 64GB of ram are served well 
by PSE, then it's worth getting that 5% of performance back.

		-ben
-- 
Fish.
