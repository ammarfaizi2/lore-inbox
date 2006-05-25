Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030495AbWEYWfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030495AbWEYWfA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 18:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbWEYWe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 18:34:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55713 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030492AbWEYWe7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 18:34:59 -0400
Date: Thu, 25 May 2006 18:34:49 -0400
From: Dave Jones <davej@redhat.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: 4Front Technologies <dev@opensound.com>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org
Subject: Re: How to check if kernel sources are installed on a system?
Message-ID: <20060525223449.GG4328@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Lee Revell <rlrevell@joe-job.com>,
	4Front Technologies <dev@opensound.com>,
	Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org
References: <e55715+usls@eGroups.com> <20060525212942.GS13513@lug-owl.de> <1148594527.31038.22.camel@mindpipe> <44762C6A.9090003@opensound.com> <1148595944.31038.28.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148595944.31038.28.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 06:25:43PM -0400, Lee Revell wrote:

 > It is unfortunate that users hitting an already-fixed bug have to
 > compile it themselves, but I think the solution is for the distros to
 > follow ALSA a bit more closely and apply the critical "no sound" fixes
 > to their packages rather than waiting for the next release.  I know for
 > a fact that Ubuntu does this.

Now imagine if every subsystem took this attitude ?
We'd end up with distro kernels with *hundreds* of patches
(Which speaking from experience managing such a mess is no fun at all).

Trying to get some developers to look at bugs in distro kernels is 
hard enough already. If they're patched to the hilt with every subsystems
patch of the day, the response becomes..
"Hmm, distro kernel crap, try and reproduce on mainline".

Given these bug reports are coming from end-users many of which don't
have a clue how to compile a kernel (nor should they), the bug report
then sits there and festers.

The answer is not "push more patches to distros" the answer is
"subsystems need to push more fixes to -stable when bugs are fixed
 instead of sitting on them in private SCMs for 2 months waiting
 for the next merge window".

		Dave

-- 
http://www.codemonkey.org.uk
