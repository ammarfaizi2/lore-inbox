Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313552AbSDQLGZ>; Wed, 17 Apr 2002 07:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313551AbSDQLGY>; Wed, 17 Apr 2002 07:06:24 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:26515
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S313536AbSDQLGW>; Wed, 17 Apr 2002 07:06:22 -0400
Date: Wed, 17 Apr 2002 07:09:37 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: bert hubert <ahu@ds9a.nl>, Olaf Fraczyk <olaf@navi.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: please merge 64-bit jiffy patches. Was Re: Why HZ on i386 is 100 ?
Message-ID: <20020417070937.A29310@animx.eu.org>
In-Reply-To: <20020416074748.GA16657@venus.local.navi.pl> <20020416233457.A1731@outpost.ds9a.nl> <20020416222156.GB20464@turbolinux.com> <20020417102828.D11817@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Trivially fixed with the existing 64-bit jiffies patches.  As it is,
> > your uptime wraps to zero after 472 days or something like that if you
> > don't have the 64-bit jiffies patch, which is totally in the realm of
> > possibility for Linux servers.
> 
> I feel your pain 
> 
> 4:26am  up 482 days, 10:33,  2 users,  load average: 0.04, 0.02, 0.00
> 
> On a very remote server.
> 
> So can we please merge the 64-bit jiffies patches? I sometimes think that
> that is the main reason why alpha DOES have HZ=1024 - the jiffies there
> don't wrap in an embarrassing way within two months :-)

Yes, but being that the alpha is 64-bit, it doesn't wrap at 49.7 days.  I've
seen mine at 60 days or so.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
