Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265379AbTFUVsk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 17:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265390AbTFUVsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 17:48:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63758 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265379AbTFUVsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 17:48:38 -0400
Date: Sat, 21 Jun 2003 23:02:37 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] Troll Tech
Message-ID: <20030621230237.D28984@flint.arm.linux.org.uk>
Mail-Followup-To: Jan Rychter <jan@rychter.com>,
	linux-kernel@vger.kernel.org
References: <03061908145500.25179@tabby> <20030619141443.GR29247@fs.tum.de> <bcsolt$37m$2@news.cistron.nl> <20030619165916.GA14404@work.bitmover.com> <20030620001217.G6248@almesberger.net> <20030620120910.3f2cb001.skraw@ithnet.com> <20030620142436.GB14404@work.bitmover.com> <20030620162719.GA4368@hh.idb.hist.no> <bd12o3$5t5$2@tangens.hometree.net> <m21xxnxfr7.fsf_-_@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m21xxnxfr7.fsf_-_@tnuctip.rychter.com>; from jan@rychter.com on Sat, Jun 21, 2003 at 02:49:48PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 21, 2003 at 02:49:48PM -0700, Jan Rychter wrote:
> And I know that I won't be able to use 2.4 much longer -- very soon
> support for new hardware will be in 2.5/2.6 only. See cpufreq for an
> example.

Picking up on this specific point...

It may be worth discussing this issue a little more and finding out
whether Marcelo would be willing to take it (maybe for .22 or .23?)

It has been in the 2.4-ac trees for some time without much problem,
and it can be configured out.

The only real sting in the tale is that it won't have the sysfs
interfaces, because there's probably no way in hell that sysfs would
appear in 2.4.  Since it is in 2.4-ac, this problem has already been
solved.

Personally, I'd like to see cpufreq go into 2.4 since its a requirement
for some ARM platforms.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

