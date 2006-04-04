Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964919AbWDDAgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbWDDAgd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 20:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbWDDAgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 20:36:33 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:8423 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964915AbWDDAgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 20:36:33 -0400
Subject: Re: [Alsa-devel] Re: Patch for AICA sound support on SEGA Dreamcast
From: Lee Revell <rlrevell@joe-job.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Takashi Iwai <tiwai@suse.de>, Carlos Munoz <carlos@kenati.com>,
       Adrian McMenamin <adrian@mcmen.demon.co.uk>,
       Alsa-devel <alsa-devel@lists.sourceforge.net>,
       linux-sh <linuxsh-dev@lists.sourceforge.net>,
       Paul Mundt <lethal@linux-sh.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200604040116.13732.s0348365@sms.ed.ac.uk>
References: <1144075522.11511.20.camel@localhost.localdomain>
	 <443162B4.60500@kenati.com> <s5hzmj28q8k.wl%tiwai@suse.de>
	 <200604040116.13732.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Date: Mon, 03 Apr 2006 20:36:25 -0400
Message-Id: <1144110986.22082.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-04 at 01:16 +0100, Alistair John Strachan wrote:
> I think this write-up provides justification. However, it is not part
> of linux/Documentation/CodingStyle. Perhaps somebody should add these
> details to this file, so that new code follows this currently
> 'unwritten' rule. 

Well, if you look at the current ALSA code, the only typedefs provided
are for backwards compatibility.  They were all removed from the drivers
months ago.  The problem is that you were working against old code.  The
main coding style rule is to follow the conventions of the nearby code,
which would mean no typedefs in the ALSA driver case.

Lee

