Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129460AbRAAXfw>; Mon, 1 Jan 2001 18:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129627AbRAAXfn>; Mon, 1 Jan 2001 18:35:43 -0500
Received: from [199.239.160.155] ([199.239.160.155]:17544 "EHLO
	tenchi.datarithm.net") by vger.kernel.org with ESMTP
	id <S129460AbRAAXf0>; Mon, 1 Jan 2001 18:35:26 -0500
Date: Mon, 1 Jan 2001 23:24:54 +0000
From: Robert Read <rread@datarithm.net>
To: Ari Pollak <compwiz@datarithm.net>, linux-kernel@vger.kernel.org
Subject: Re: devices.txt inconsistency
Message-ID: <20010101232454.C8481@tenchi.datarithm.net>
Mail-Followup-To: Ari Pollak <compwiz@datarithm.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010101170654.A5856@sourceware.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010101170654.A5856@sourceware.net>; from compwiz@bigfoot.com on Mon, Jan 01, 2001 at 05:06:54PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

devices.txt does need some updating. It still lists char-major-13 as
the PC Speaker, but 13 appears to be the major for new input driver,
and the joystick driver is now a minor off the that.  Are there now
two Joystick drivers, or can char-major-15 be obsoleted/deleted?

robert

On Mon, Jan 01, 2001 at 05:06:54PM -0500, Ari Pollak wrote:
> This has not been fixed for at least a year that i can remember - in
> Documentation/devices.txt, it says /dev/js* should be char-major-15*,
> but in Documentation/joystick.txt it says it should be char-major-13.
> I'm assuming joystick.txt is the correct one, and devices.txt should be
> updated to reflect this.. before 2.4.0 would be nice.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
