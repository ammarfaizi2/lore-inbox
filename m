Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272173AbRIENOM>; Wed, 5 Sep 2001 09:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272176AbRIENOD>; Wed, 5 Sep 2001 09:14:03 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:27565 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S272175AbRIENNx>;
	Wed, 5 Sep 2001 09:13:53 -0400
Date: Wed, 05 Sep 2001 14:14:09 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: =?ISO-8859-1?Q?christophe_barb=E9?= <christophe.barbe@lineo.fr>,
        David Schwartz <davids@webmaster.com>
Cc: linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: Linux 2.4.9-ac6
Message-ID: <1269703968.999699248@[169.254.198.40]>
In-Reply-To: <20010905145039.A10655@pc8.lineo.fr>
In-Reply-To: <20010905145039.A10655@pc8.lineo.fr>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Would it not be possible with your scheme to package a closed source
> driver in an open source wrapper driver and then defeat your tainting
> technique.

It would also be theoretically possible for an evil driver merchant
to twiddle the flag back via /dev/kmem (for instance). Or load the
module by manipulation of /dev/kmem. Or for the bug-reporting user
to patch their kernel so that the flag never got set and hence
disguise the presence of an nvidia driver (etc.) in a misguided
attempt to wangle support out of Alan et al.

However, I understood the point of the exercize to be a first pass
hueristic to flag bug reports from systems running modules for
which Alan and others haven't got, and can't get the source. It's
not going to be perfect (see above), but equally doesn't need to be.
I'm sure users do all sorts of other 'well don't do that, then'
stuff which wastes the time of those reading bug reports.

--
Alex Bligh
