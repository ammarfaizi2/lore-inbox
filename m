Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVEaWfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVEaWfF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 18:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVEaWfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 18:35:04 -0400
Received: from mail.emacinc.com ([208.248.202.76]:61325 "EHLO mail.emacinc.com")
	by vger.kernel.org with ESMTP id S261182AbVEaWet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 18:34:49 -0400
From: NZG <ngustavson@emacinc.com>
Organization: EMAC.Inc
To: linux-kernel@vger.kernel.org
Date: Tue, 31 May 2005 17:33:02 -0500
User-Agent: KMail/1.7.1
Cc: Andrea Arcangeli <andrea@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
       Esben Nielsen <simlo@phys.au.dk>, akpm@osdl.org, hch@infradead.org,
       dwalker@mvista.com, Ingo Molnar <mingo@elte.hu>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, Andi Kleen <ak@muc.de>,
       "Bill Huey (hui)" <bhuey@lnxw.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       James Bruce <bruce@andrew.cmu.edu>
References: <Pine.OSF.4.05.10505311347290.1707-100000@da410.phys.au.dk> <1117574551.5511.19.camel@localhost.localdomain> <20050531221505.GZ5413@g5.random>
In-Reply-To: <20050531221505.GZ5413@g5.random>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200505311733.02693.ngustavson@emacinc.com>
X-SA-Exim-Connect-IP: 208.248.202.77
X-SA-Exim-Mail-From: ngustavson@emacinc.com
Subject: RT patch acceptance
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 May 2005 17:15, Andrea Arcangeli wrote:
> If RT is merged and RTAI not, that might be simpler to install, but I
> wouldn't judje on what's simpler to use based on mainline inclusion or
> not. I don't work in the emebdded-RT space, but if I had to build an
> hard-RT embedded app for myself and I didn't need to run syscalls in
> real time (i.e. no audio ioctls), I'd sure start with RTAI.
If I can throw my two-cents in here, I'm an embedded RT developer, and I agree 
with Andrea. 
RTAI is a very mature, completely open source real time system these days. 
Regardless of the skill and manpower being leveraged on the RT patch, I gotta 
say it looks like your re-inventing the wheel by not using the work that's 
already been done in RTAI.

Seems like there is a lot of RTAI speculation going on here.
Maybe their list should be CC'd on this thread?

NZG.
