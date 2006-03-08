Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWCHAzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWCHAzK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 19:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbWCHAzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 19:55:10 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:11678 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751926AbWCHAzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 19:55:09 -0500
Subject: Re: [opensuse-factory] Re[2]: 2.6.16 serious consequences /
	GPL_EXPORT_SYMBOL / USB drivers of major vendor excluded
From: Lee Revell <rlrevell@joe-job.com>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: Silviu Marin-Caea <silviu_marin-caea@fieldinsights.ro>,
       opensuse-factory@opensuse.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060307233724.GB13357@merlin.emma.line.org>
References: <OF2725219B.50D2AC48-ONC1257129.00416F63-C1257129.00464A42@avm.de>
	 <200603070942.31774.silviu_marin-caea@fieldinsights.ro>
	 <1141769422.767.99.camel@mindpipe>
	 <20060307233724.GB13357@merlin.emma.line.org>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 19:55:06 -0500
Message-Id: <1141779307.767.107.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-08 at 00:37 +0100, Matthias Andree wrote:
> On Tue, 07 Mar 2006, Lee Revell wrote:
> 
> > If they are doing serious realtime DSP then they should get better
> > results in userspace anyway, because they get to use the floating point
> > unit which isn't allowed in the kernel.
> 
> It's not as though every algorithm needed float just because it said DSP
> (some of those are actually fixed-point or something like that) at a time.

I didn't mean to imply that, I was just pointing out it's another
feature available in userspace that can't be used in the kernel.  Audio
stuff like the AC3 encoder/decoders I've seen in Windows drivers use
floating point instructions for example.

Lee

