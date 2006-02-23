Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWBWTFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWBWTFZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 14:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWBWTFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 14:05:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6573 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751434AbWBWTFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 14:05:24 -0500
Date: Thu, 23 Feb 2006 14:04:24 -0500
From: Dave Jones <davej@redhat.com>
To: Thierry Vignaud <tvignaud@mandriva.com>
Cc: Matthias Hensler <matthias@wspse.de>, Pavel Machek <pavel@ucw.cz>,
       Lee Revell <rlrevell@joe-job.com>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, nigel@suspend2.net,
       rjw@sisk.pl
Subject: Re: agp fixes in suspend2 patch
Message-ID: <20060223190424.GB6213@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Thierry Vignaud <tvignaud@mandriva.com>,
	Matthias Hensler <matthias@wspse.de>, Pavel Machek <pavel@ucw.cz>,
	Lee Revell <rlrevell@joe-job.com>, Sebastian Kgler <sebas@kde.org>,
	kernel list <linux-kernel@vger.kernel.org>, nigel@suspend2.net,
	rjw@sisk.pl
References: <20060220093911.GB19293@kobayashi-maru.wspse.de> <1140430002.3429.4.camel@mindpipe> <20060220101532.GB21817@kobayashi-maru.wspse.de> <1140431058.3429.15.camel@mindpipe> <20060220103329.GE21817@kobayashi-maru.wspse.de> <1140434146.3429.17.camel@mindpipe> <20060220122443.GB3495@kobayashi-maru.wspse.de> <20060220132842.GC23277@atrey.karlin.mff.cuni.cz> <20060220135145.GA5534@kobayashi-maru.wspse.de> <m2bqwzl68x.fsf_-_@vador.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2bqwzl68x.fsf_-_@vador.mandriva.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 05:15:26PM +0100, Thierry Vignaud wrote:
 > Matthias Hensler <matthias@wspse.de> writes:
 > 
 > > > > Third try sound was gone. On the fourth try the system hanged
 > > > > after starting ppracer (to test GLX/DRI on my i855).
 > > > 
 > > > Submit AGP fixes, then.
 > > 
 > > I think no such fixes are in Suspend 2, but still it works there.
 > 
 > actually there're (well i didn't compile nor test suspend2) in
 > 100-suspend2-2.2-for-2.6.15.1.patch:
 > 
 > it introduces agp_suspend.h and uses it in the various agp backend
 > drivers in order to suspend/resume agp controllers (only for ati and
 > nvidia though).

if they're the patches I'm thinking of, equivalent fixes went into 2.6.16rc already

		Dave

