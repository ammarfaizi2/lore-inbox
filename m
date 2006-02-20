Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbWBTOJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbWBTOJV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbWBTOJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:09:21 -0500
Received: from odin.mimer.no ([213.184.200.1]:46028 "EHLO odin.mimer.no")
	by vger.kernel.org with ESMTP id S964922AbWBTOJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:09:20 -0500
From: Harald Arnesen <harald@skogtun.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthias Hensler <matthias@wspse.de>, Lee Revell <rlrevell@joe-job.com>,
       Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, nigel@suspend2.net,
       rjw@sisk.pl
Subject: Re: Which is simpler?
References: <200602110116.57639.sebas@kde.org>
	<20060211104130.GA28282@kobayashi-maru.wspse.de>
	<20060218142610.GT3490@openzaurus.ucw.cz>
	<20060220093911.GB19293@kobayashi-maru.wspse.de>
	<1140430002.3429.4.camel@mindpipe>
	<20060220101532.GB21817@kobayashi-maru.wspse.de>
	<1140431058.3429.15.camel@mindpipe>
	<20060220103329.GE21817@kobayashi-maru.wspse.de>
	<1140434146.3429.17.camel@mindpipe>
	<20060220122443.GB3495@kobayashi-maru.wspse.de>
	<20060220132842.GC23277@atrey.karlin.mff.cuni.cz>
Date: Mon, 20 Feb 2006 15:08:12 +0100
In-Reply-To: <20060220132842.GC23277@atrey.karlin.mff.cuni.cz> (Pavel Machek's
	message of "Mon, 20 Feb 2006 14:28:42 +0100")
Message-ID: <8764nagm2b.fsf@basilikum.skogtun.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

>> Ah, and now the part I really like, some hard numbers:
>> swsusp takes between 26 and 30 seconds to suspend (in my four tries: 26,
>> 30, 28, 26) and between 35 and 45 seconds to resume (35, 45, 39, 37).
>> 
>> Suspend 2 does suspend in around 14-16 seconds, and resume in 18 to 21.
>> 
>> That is factor 2!
>
> Does that include time to boot resume kernel? It will not be that
> dramatic with that time included, and it is only fair to include
> it. Anyway uswsusp solves that issue.

On my old ThinkPad, the difference is more like a factor of 3 to 4 -
from the moment I press the power button until X is up and running.

Suspend2 resumes faster than Windows 2000 on this machine.
-- 
Hilsen Harald.

