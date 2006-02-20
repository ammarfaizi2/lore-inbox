Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWBTKCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWBTKCq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 05:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWBTKCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 05:02:45 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:37267 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932438AbWBTKCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 05:02:45 -0500
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10]
	[Suspend2] Modules support.)
From: Lee Revell <rlrevell@joe-job.com>
To: Matthias Hensler <matthias@wspse.de>
Cc: Pavel Machek <pavel@suse.cz>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, nigel@suspend2.net,
       rjw@sisk.pl
In-Reply-To: <20060220093911.GB19293@kobayashi-maru.wspse.de>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <200602091926.38666.nigel@suspend2.net> <20060209232453.GC3389@elf.ucw.cz>
	 <200602110116.57639.sebas@kde.org>
	 <20060211104130.GA28282@kobayashi-maru.wspse.de>
	 <20060218142610.GT3490@openzaurus.ucw.cz>
	 <20060220093911.GB19293@kobayashi-maru.wspse.de>
Content-Type: text/plain
Date: Mon, 20 Feb 2006 05:02:38 -0500
Message-Id: <1140429758.3429.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-20 at 10:39 +0100, Matthias Hensler wrote:
> > It is slightly slower,
> 
> Sorry, but that is just unacceptable. 

Um... suspend2 puts extra tests into really hot paths like fork(), which
is equally unacceptable to many people.

Why can't people understand that arguing "it works" without any
consideration of possible performance tradeoffs is not a good enough
argument for merging?

Lee

