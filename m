Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWGWSeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWGWSeA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 14:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWGWSeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 14:34:00 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:44062 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750755AbWGWSd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 14:33:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=X4ci0xJY0BA+ZIWhkO93b88pacLRrDEZSWwUKj7UOHptHy3610R4E3G8feczRoq4te32w3nsD+mWTQQGga2gnEHl08i/meDPwSZE/db/YvnQmDM1elkBSK8lubYfk+jWCzdpK1JV33XBe/gd/HmfpSyYpxxOhGlQUIJsoSfI0ek=
From: Patrick McFarland <diablod3@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: remove cpu hotplug bustification in cpufreq.
Date: Sun, 23 Jul 2006 14:34:23 -0400
User-Agent: KMail/1.9.1
Cc: Arjan van de Ven <arjan@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>,
       linux-kernel@vger.kernel.org, davej@redhat.com,
       Andrew Morton <akpm@osdl.org>
References: <20060722194018.GA28924@redhat.com> <Pine.LNX.4.64.0607230955130.29649@g5.osdl.org> <Pine.LNX.4.64.0607231107510.29649@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607231107510.29649@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607231434.24376.diablod3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 July 2006 14:12, Linus Torvalds wrote:
> On Sun, 23 Jul 2006, Linus Torvalds wrote:
> [ Linus bangs his head against the wall until tears of blood course down
>   his face ]

I know how you feel.

> cpufreq (or at least ondemand) must DIE! And the people who wrote that
> crap should have red-hot pokers jammed into some very uncomfortable
> places.

You know what else must die? powernowd... which does exactly what the 
conservative governor does, but takes about a meg of memory to do it, and it 
doesn't even provide stuff like changing behavior based on ac/battery state 
or lm_sensors feedback.

-- 
Patrick McFarland || www.AdTerrasPerAspera.com
"Computer games don't affect kids; I mean if Pac-Man affected us as kids,
we'd all be running around in darkened rooms, munching magic pills and
listening to repetitive electronic music." -- Kristian Wilson, Nintendo,
Inc, 1989

