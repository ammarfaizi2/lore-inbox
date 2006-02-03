Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWBCBs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWBCBs6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 20:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWBCBs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 20:48:58 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:8196 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S964834AbWBCBs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 20:48:57 -0500
Date: Fri, 3 Feb 2006 02:48:46 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, pavel@ucw.cz, nigel@suspend2.net,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060203014846.GA61221@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
	pavel@ucw.cz, nigel@suspend2.net, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602022131.59928.nigel@suspend2.net> <20060202115907.GH1884@elf.ucw.cz> <200602022214.52752.nigel@suspend2.net> <20060202152316.GC8944@ucw.cz> <20060202132708.62881af6.akpm@osdl.org> <1138916079.15691.130.camel@mindpipe> <20060202142323.088a585c.akpm@osdl.org> <1138919381.15691.162.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138919381.15691.162.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 05:29:40PM -0500, Lee Revell wrote:
> Follow up - do we have a rough idea how bad the suspend problem is, like
> approximately what % of laptops don't DTRT and just suspend when you
> close the lid?

None of the Dells we use at work (various models) handle suspend (both
ram and disk) reliably.  Got everything from not resuming when pushing
the button (PWRF not giving an ACPI event while PWRC does), screen not
coming back (as usual), system not coming back the second time (go
figure) or resume eating up / from time to time.  At that point people
there are buying Macs.

I'm going to get a sacrificial (but modern) dell laptop in a month or
two.  I'll try to make things actually reliable on that one, including
video.  I don't have great hopes though.

'course the current state of the drm/fb interaction is yet another can
of worms, one in a good way of being solved though.

  OG.

[1] Reverse engineering is one of my hobbies
