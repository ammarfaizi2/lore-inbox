Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932660AbWBTTqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660AbWBTTqO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 14:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932665AbWBTTqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 14:46:14 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:27297 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932663AbWBTTqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 14:46:13 -0500
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10]
	[Suspend2] Modules support.)
From: Lee Revell <rlrevell@joe-job.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: dtor_core@ameritech.net, Pavel Machek <pavel@ucw.cz>,
       Mark Lord <lkml@rtr.ca>, Nigel Cunningham <nigel@suspend2.net>,
       Matthias Hensler <matthias@wspse.de>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200602201722.09442.rjw@sisk.pl>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <20060220145405.GD1673@atrey.karlin.mff.cuni.cz>
	 <d120d5000602200708n2984fda9j62c3d7ba21b3e8ae@mail.gmail.com>
	 <200602201722.09442.rjw@sisk.pl>
Content-Type: text/plain
Date: Mon, 20 Feb 2006 14:46:10 -0500
Message-Id: <1140464770.6722.10.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-20 at 17:22 +0100, Rafael J. Wysocki wrote:
> Certainly not.
> 
> The problem is the soft lockup watchdog tends to produce
> false-positives
> related to the clock resume vs timer interrupt dependencies that are
> hard to trace.
> 
> I used to get those on a regular basis until the timer resume on
> x86-64
> got fixed a month ago or so. 

So it's uncovering bugs, exactly as intended.

Lee

