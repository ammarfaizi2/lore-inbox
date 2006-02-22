Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWBVQPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWBVQPi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWBVQPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:15:38 -0500
Received: from ezoffice.mandriva.com ([84.14.106.134]:52495 "EHLO
	office.mandriva.com") by vger.kernel.org with ESMTP
	id S1750733AbWBVQPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:15:37 -0500
From: Thierry Vignaud <tvignaud@mandriva.com>
To: Matthias Hensler <matthias@wspse.de>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Revell <rlrevell@joe-job.com>,
       Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, nigel@suspend2.net,
       rjw@sisk.pl
Subject: agp fixes in suspend2 patch
Organization: Mandrakesoft
References: <20060211104130.GA28282@kobayashi-maru.wspse.de>
	<20060218142610.GT3490@openzaurus.ucw.cz>
	<20060220093911.GB19293@kobayashi-maru.wspse.de>
	<1140430002.3429.4.camel@mindpipe>
	<20060220101532.GB21817@kobayashi-maru.wspse.de>
	<1140431058.3429.15.camel@mindpipe>
	<20060220103329.GE21817@kobayashi-maru.wspse.de>
	<1140434146.3429.17.camel@mindpipe>
	<20060220122443.GB3495@kobayashi-maru.wspse.de>
	<20060220132842.GC23277@atrey.karlin.mff.cuni.cz>
	<20060220135145.GA5534@kobayashi-maru.wspse.de>
X-URL: <http://www.linux-mandrake.com/
Date: Wed, 22 Feb 2006 17:15:26 +0100
In-Reply-To: <20060220135145.GA5534@kobayashi-maru.wspse.de> (Matthias
	Hensler's message of "Mon, 20 Feb 2006 14:51:45 +0100")
Message-ID: <m2bqwzl68x.fsf_-_@vador.mandriva.com>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Hensler <matthias@wspse.de> writes:

> > > Third try sound was gone. On the fourth try the system hanged
> > > after starting ppracer (to test GLX/DRI on my i855).
> > 
> > Submit AGP fixes, then.
> 
> I think no such fixes are in Suspend 2, but still it works there.

actually there're (well i didn't compile nor test suspend2) in
100-suspend2-2.2-for-2.6.15.1.patch:

it introduces agp_suspend.h and uses it in the various agp backend
drivers in order to suspend/resume agp controllers (only for ati and
nvidia though).

