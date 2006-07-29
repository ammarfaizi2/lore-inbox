Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752065AbWG2APr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbWG2APr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 20:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbWG2APr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 20:15:47 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:20646
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1752065AbWG2APq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 20:15:46 -0400
Subject: Re: 2.6.18-rc2-mm1 timer int 0 doesn't work
From: Paul Fulghum <paulkf@microgate.com>
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <20060728233851.GA35643@muc.de>
References: <20060727015639.9c89db57.akpm@osdl.org>
	 <1154112276.3530.3.camel@amdx2.microgate.com>
	 <20060728144854.44c4f557.akpm@osdl.org>  <20060728233851.GA35643@muc.de>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 19:15:26 -0500
Message-Id: <1154132126.3349.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-29 at 01:38 +0200, Andi Kleen wrote:
> What happened to the new lines? It looks like a bad alphabet soup

When I download and edit syslog from the specified URL, it has newlines.

> Do you perhaps have a boot log from before 2.6.17 (e.g. 2.6.16)? 

I can get a syslog from < 2.6.17
but not right now as that machine is at the office.

> It's remove-timer-fallback likely. I was working on that already.
> 
> Some boards go into the timer fallback path since 2.6.17/64bit for so 
> far unknown reasons and that doesn't work anymore because I removed the 
> fallback path.

I might burn some time tomorrow and go into the office
to try removing that patch. By Monday at the latest.

I'm doing a build on my home machine now to see if it
happens there also.

--
Paul




