Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264430AbUGPW7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264430AbUGPW7N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 18:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266596AbUGPW7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 18:59:13 -0400
Received: from main.gmane.org ([80.91.224.249]:21962 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264430AbUGPW7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 18:59:12 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Volker Braun <volker.braun@physik.hu-berlin.de>
Subject: Re: ACPI Hibernate and Suspend Strange behavior 2.6.7/-mm1
Date: Fri, 16 Jul 2004 18:59:08 -0400
Message-ID: <pan.2004.07.16.22.59.06.759930@physik.hu-berlin.de>
References: <A6974D8E5F98D511BB910002A50A6647615FEF48@hdsmsx403.hd.intel.com> <1089054013.15671.48.camel@dhcppc4> <pan.2004.07.06.14.14.47.995955@physik.hu-berlin.de> <slrncfb55n.dkv.jgoerzen@christoph.complete.org> <pan.2004.07.14.23.28.53.135582@physik.hu-berlin.de> <20040716170052.GC8264@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: carrot.hep.upenn.edu
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Cc: linux-thinkpad@linux-thinkpad.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2004 19:00:52 +0200, Pavel Machek wrote:
>> > And, if I would shine
>> > a bright light on the screen, I could make out text on it.  In other
>> > words, the backlight was off but it was still displaying stuff.
> 
> If it is still there after half an hour, its certainly part of the problem.

I agree in principle, but I'm also open to the possibility of a very
faint afterimage.

I see two possibilities to "turn off the back light":

1) Push the tiny sensor next to the hinge over the "access ibm" button
manually. This cuts power to the backlight (assuming you did not associate
suspend or anything to the ensuing "LID" acpi event). I can still see the
screen rather clearly, just without the backlight. Its easy to read text
even in a moderately lit room.

2) use "radeontool light off". This cuts power to the backlight
and the lcd. I cannot see the slightest thing on the display, it goes
completely black as if the computer were switched off.

John, could you please comment on what you see during ACPI S3?

Best,
Volker


