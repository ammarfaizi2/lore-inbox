Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281648AbRLGORS>; Fri, 7 Dec 2001 09:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281541AbRLGOQ6>; Fri, 7 Dec 2001 09:16:58 -0500
Received: from uisge.3dlabs.com ([193.133.230.45]:5332 "EHLO uisge.3dlabs.com")
	by vger.kernel.org with ESMTP id <S281512AbRLGOQt>;
	Fri, 7 Dec 2001 09:16:49 -0500
Date: Fri, 7 Dec 2001 14:15:43 +0000
From: Paul Sargent <Paul.Sargent@3dlabs.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2GB process crashing on 2.4.14
Message-ID: <20011207141543.G31161@3dlabs.com>
In-Reply-To: <20011207125821.D31161@3dlabs.com.suse.lists.linux.kernel> <E16CKrx-0005nL-00@the-village.bc.nu.suse.lists.linux.kernel> <20011207132317.E31161@3dlabs.com.suse.lists.linux.kernel> <p73k7vz6sc9.fsf@amdsim2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73k7vz6sc9.fsf@amdsim2.suse.de>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 03:02:46PM +0100, Andi Kleen wrote:
> Paul Sargent <Paul.Sargent@3dlabs.com> writes:
> 
> 
> > So if I was hitting this limit then I should see no / very few gaps, in the
> > /proc/<pid>/maps. Is that true?
> 
> It usually fails when malloc() hits your libraries.

[remedies to increase available address space snipped]

> -Andi
> 
> P.S.: I'm pretty sure this is a FAQ.

Yes, I think your right, this is. At least, I've come across it before, but
I'm not convinced this is my problem in this case.

I think it's failing about 1GB before getting to the bottom of the
libraries, but I'm going to monitor maps over the weekend to ensure it
doesn't start doing anything wacky just before crashing.

Paul
-- 
Paul Sargent
Tel: +44 (1784) 476669
Fax: +44 (1784) 470699
mailto: Paul.Sargent@3Dlabs.com
