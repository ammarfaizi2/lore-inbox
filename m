Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVBWW75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVBWW75 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 17:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVBWW6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 17:58:54 -0500
Received: from jagor.srce.hr ([161.53.2.130]:45300 "EHLO jagor.srce.hr")
	by vger.kernel.org with ESMTP id S261628AbVBWW4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 17:56:42 -0500
Message-ID: <421D0A21.5000401@spymac.com>
Date: Wed, 23 Feb 2005 23:56:33 +0100
From: zhilla <zhilla@spymac.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Well, powersaving weirdness.
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not the most clever subject, I agree :)

hell, i'm not sure if this is a KERNEL bug. but it definitely is an 
annoyance, so...
distro is slackware 10.
i have a small script i run every time i connect to the internet (and i 
connect via dial-up when )
this is one command in the script:
/usr/sbin/ntpdate zg1.ntp.carnet.hr
well, as my bios battery is a bit weak, hardware clock resets to its 
defaults when computer is powerless for few minutes.
ok, i fire it up, time is set to something like ie 0:01:15 1/1/2003, 
connect to the net, it sets the time ie. 23:46:23 23/02/2005... and its 
monitor off! puff, powersaving (is that in acpi? apm?) suddenly decides 
that computer is left untouched for more 2-3 years now and initiates 
powersaving mode. ok, not a big problem, but somehow i think it IS a 
easily fixable small kernel bug... if i'm wrong, please direct  me to 
the right place to report this? thanks.
