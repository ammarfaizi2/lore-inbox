Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264107AbTDWQy4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 12:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264120AbTDWQy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 12:54:56 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:2999 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264107AbTDWQyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 12:54:54 -0400
Date: Wed, 23 Apr 2003 09:56:03 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Matthias Schniedermeyer <ms@citd.de>, Marc Giger <gigerstyle@gmx.ch>
cc: linux-kernel <linux-kernel@vger.kernel.org>, pat@suwalski.net
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <1508310000.1051116963@flay>
In-Reply-To: <20030423164558.GA12202@citd.de>
References: <21660000.1051114998@[10.10.2.4]> <20030423164558.GA12202@citd.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, I agree with the submitter. Having the volume default to 0
is stupid - userspace tools are all very well, but no substitute for
sensible kernel defaults.

--On Wednesday, April 23, 2003 18:45:58 +0200 Matthias Schniedermeyer <ms@citd.de> wrote:

> On Wed, Apr 23, 2003 at 09:23:18AM -0700, Martin J. Bligh wrote:
>> http://bugme.osdl.org/show_bug.cgi?id=623
>> 
>>            Summary: Volume not remembered.
>>     Kernel Version: 2.5.x
>>             Status: NEW
>>           Severity: normal
>>              Owner: bugme-janitors@lists.osdl.org
>>          Submitter: pat@suwalski.net
>> 
>> 
>> Distribution: Gentoo
>> Hardware Environment: ALSA, 82801AA AC'97 Audio
>> Software Environment: Gnome
>> Problem Description:
>> Not certain if this is kernel or ALSA specific. In 2.4.x OSS volume levels
>> were remembered for the various mixers. Now all of them always default to 0
>> at bootup. I never ran ALSA with the 2.4 series, but it would be nice to
>> remember volumes.
>> Should I be bugging the alsa-project people instead?
>> 
>> Steps to reproduce:
>> Set a volume level, reboot, level has been reset.
> 
> OSS didn't do that "itself". He must have had a (maybe init-)script that
> saved the mixer-settings at shutdown (or whenever) and restored the
> values at startup.
> 
> Definitly not a kernel issue. (Hint, time for a FAQ on "common" issues
> that are not problem of the kernel. And maybe a "RESOLVE because it's a
> FAQ"-Status :-)
> 
> e.g. Debian does install an init-script it when you install the
> "aumix"-package.
> 
> 
> 
> Bis denn
> 
> -- 
> Real Programmers consider "what you see is what you get" to be just as 
> bad a concept in Text Editors as it is in women. No, the Real Programmer
> wants a "you asked for it, you got it" text editor -- complicated, 
> cryptic, powerful, unforgiving, dangerous.
> 
> 


