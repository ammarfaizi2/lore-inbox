Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWG3Ley@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWG3Ley (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 07:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWG3Ley
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 07:34:54 -0400
Received: from mail.trixing.net ([87.230.125.58]:11924 "EHLO ds666.l4x.org")
	by vger.kernel.org with ESMTP id S932278AbWG3Lex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 07:34:53 -0400
Message-ID: <44CC993B.6070309@l4x.org>
Date: Sun, 30 Jul 2006 13:34:19 +0200
From: Jan Dittmer <jdi@l4x.org>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Matthew Garrett <mjg59@srcf.ucam.org>
CC: Pavel Machek <pavel@suse.cz>, Jirka Lenost Benc <jbenc@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       ipw2100-admin@linux.intel.com
References: <20060730104042.GE1920@elf.ucw.cz> <20060730112827.GA25540@srcf.ucam.org>
In-Reply-To: <20060730112827.GA25540@srcf.ucam.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 192.168.1.3
X-SA-Exim-Mail-From: jdi@l4x.org
Subject: Re: ipw3945 status
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on ds666.l4x.org)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett schrieb:
> On Sun, Jul 30, 2006 at 12:40:42PM +0200, Pavel Machek wrote:
> 
> 
>>I'm unfortunate enough to have x60 with ipw card. Card works okay, but
>>driver is 16K LoC and needs binary daemon (ugh). Plus, it lives as an
>>external module...
> 
> 
> I have a mostly working replacement for the binary daemon, but it causes 
> the firmware to crash at the point where it triggers an association. If 
> anyone's keen on trying to figure out what's up, I'll clean up the code 
> and stick it somewhere.

Why not get rid of the daemon like bsd did [0]? Otherwise in
5 years you'll have 42 daemons running which communicate with
the firmware of various devices, each having a different inter-
face.

Jan

[0] http://kerneltrap.org/node/6650


