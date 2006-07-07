Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWGGSVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWGGSVV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 14:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWGGSVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 14:21:21 -0400
Received: from mailrelay.linspire.com ([130.94.123.203]:41875 "EHLO
	mailrelay.linspire.com") by vger.kernel.org with ESMTP
	id S1750752AbWGGSVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 14:21:20 -0400
X-ASG-Debug-ID: 1152296469-31583-168-0
X-Barracuda-URL: http://mailrelay.linspire.com:43970/cgi-bin/mark.cgi
Message-ID: <44AEA615.9040302@linspireinc.com>
Date: Fri, 07 Jul 2006 11:21:09 -0700
From: David Fox <david.fox@linspireinc.com>
User-Agent: Email 1.5.0.4 (X11/20060705)
MIME-Version: 1.0
To: Rohan Dhruva <rohandhruva@gmail.com>
CC: Pavel Machek <pavel@ucw.cz>, suspend2-devel@lists.suspend2.net,
       linux-kernel@vger.kernel.org, Jan Rychter <jan@rychter.com>
X-ASG-Orig-Subj: Re: [Suspend2-devel] Re: swsusp / suspend2 reliability
Subject: Re: [Suspend2-devel] Re: swsusp / suspend2 reliability
References: <200606270147.16501.ncunningham@linuxmail.org>	<20060627133321.GB3019@elf.ucw.cz> <44A14D3D.8060003@wasp.net.au>	<20060627154130.GA31351@rhlx01.fht-esslingen.de>	<20060627222234.GP29199@elf.ucw.cz>	<m2k66qzgri.fsf@tnuctip.rychter.com> <20060707135031.GA4239@ucw.cz> <a149495b0607070705p261b4690n919b4f97896bdc12@mail.gmail.com>
In-Reply-To: <a149495b0607070705p261b4690n919b4f97896bdc12@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ASG-Whitelist: HEADER (207.67.194.2)
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=8.0 QUARANTINE_LEVEL=3.5 KILL_LEVEL=7.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohan Dhruva wrote:
> Why not
> take the best from both swsusp and suspend2, and get a nice
> implementation into the kernel, that works most of the times !

Well, this is the ten thousand dollar question - why not indeed?  Pavel 
says "Problems are in drivers, and drivers are shared", but suspend2 
works around this by unloading certain drivers before suspending, and 
otherwise hacking around the difficulties.  This is, I think, what is 
meant when suspend2 is said to support scripting.  It may not be a 
pleasing approach from a theoretical standpoint, but it seems to be the 
only way to get a reliable implementation in a timely fashion -- 
reliable in the sense of being most likely to work on a randomly chosen 
machine without custom configuration.


