Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131534AbRA3CH6>; Mon, 29 Jan 2001 21:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132004AbRA3CHs>; Mon, 29 Jan 2001 21:07:48 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:36361 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S131534AbRA3CHc>; Mon, 29 Jan 2001 21:07:32 -0500
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE602@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'David Riley'" <oscar@the-rileys.net>, linux-kernel@vger.kernel.org
Subject: RE: *massive* slowdowns on 2.4.1-pre1[1|2]
Date: Mon, 29 Jan 2001 18:06:53 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you have ACPI enabled, it is the culprit.

(I'm workin' on it! ;-)

Anyway, ACPI driver is marked "developmental and/or incomplete" and will not
be otherwise any time soon so it's broken-ness should IMO not hold up kernel
releases.

Regards -- Andy
(ACPI maintainer)


> -----Original Message-----
> From: David Riley [mailto:oscar@the-rileys.net]
> Sent: Monday, January 29, 2001 5:59 PM
> To: linux-kernel@vger.kernel.org
> Subject: *massive* slowdowns on 2.4.1-pre1[1|2]
> 
> 
> Sorry if this is a redundant post, but I didn't see any related posts
> (at least from the subject lines)...
> 
> Kernel 2.4.1-pre11 and pre12 are both massively slower than 
> 2.4.0 on the
> same machine, compiled with the same options.  The machine is a Athlon
> 900 on a KT133 chipset.  The slowdown is noticealbe in all areas...
> booting takes over five minutes, keyboard input is noticeably delayed,
> and the PC speaker makes much longer beeps when beeping the 
> console.  I
> just wanted to post this since 2.4.1 is soon for release (at least
> according to Linus' post on -pre11) and we wouldn't want to 
> release this
> if it affects more than just me.  I've tried a number of different
> options to make this work, but none have seemed to work.  BTW, my
> problems are nothing similar to the current discussion of KT133
> misbehaviour, especially since this machine works perfectly on 2.4.0.
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
