Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWDRQoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWDRQoH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 12:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWDRQoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 12:44:07 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:51614 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1751095AbWDRQoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 12:44:05 -0400
Message-ID: <44451704.6000709@s5r6.in-berlin.de>
Date: Tue, 18 Apr 2006 18:42:44 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: de, en
MIME-Version: 1.0
To: Jon Masters <jonathan@jonmasters.org>
CC: Jody McIntyre <scjody@modernduck.com>,
       linux1394-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Data about Apple iPod, Mac, Powerbook, iBook needed
References: <4437F493.9000803@s5r6.in-berlin.de>	 <35fb2e590604150055t29422445k20b5f95d3dce634d@mail.gmail.com>	 <20060418094126.GH5346@conscoop.ottawa.on.ca> <35fb2e590604180606w53cda64fn72c0720c846c8ba2@mail.gmail.com>
In-Reply-To: <35fb2e590604180606w53cda64fn72c0720c846c8ba2@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Masters wrote:
> On 4/18/06, Jody McIntyre <scjody@modernduck.com> wrote:
>> On Sat, Apr 15, 2006 at 08:55:30AM +0100, Jon Masters wrote:
>> > [0] All the Powerbooks here run only Linux.
>>
>> You can still do the 't' thing.  It's in the firmware.  However, Stefan
>> has already sent me a patch so he probably doesn't need this information
>> anymore.
> 
> Sure. I was just hinting that the original post implied one owned a
> Mac and/or a Linux box and that the two weren't necessarily the same
> thing :-)

Jon, if you have the time and two available machines, I would still be
interested if there is a firmware_revision logged by sbp2 when it logs
in into a Powerbook in target disk mode.

(Remember to unload/reload sbp2 with "modprobe sbp2
force_inquiry_hack=1" on the machine which is running Linux; sbp2 would
not print that log message otherwise. There will also be no log message
if the Powerbook's firmware does not generate a firmware_revision entry
in the first place, as has been reported by iBook owners.)

TIA,
-- 
Stefan Richter
-=====-=-==- -=-- =--=-
http://arcgraph.de/sr/
