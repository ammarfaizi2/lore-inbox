Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263106AbTH0FXH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 01:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTH0FXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 01:23:07 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:4368 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263106AbTH0FXD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 01:23:03 -0400
Date: Wed, 27 Aug 2003 02:21:37 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: =?ISO-8859-1?Q?Ram=F3n?= Rey
	 =?ISO-8859-1?Q?Vicente=F3=AE=A0=92?= <retes_simbad@yahoo.es>
Cc: aradorlinux@yahoo.es, bunk@fs.tum.de, jamagallon@able.es,
       linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.22 released
Message-Id: <20030827022137.7cf9290e.vmlinuz386@yahoo.com.ar>
In-Reply-To: <1061950515.1166.41.camel@debian>
References: <200308251148.h7PBmU8B027700@hera.kernel.org>
	<20030825132358.GC14108@merlin.emma.line.org>
	<1061818535.1175.27.camel@debian>
	<20030825211307.GA3346@werewolf.able.es>
	<20030825222215.GX7038@fs.tum.de>
	<1061857293.15168.3.camel@debian>
	<20030826234901.1726adec.aradorlinux@yahoo.es>
	<20030826215544.GI7038@fs.tum.de>
	<20030827002947.078cbdc8.aradorlinux@yahoo.es>
	<1061950515.1166.41.camel@debian>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003 04:15:16 +0200, Ramón Rey Vicenteó® ’ wrote:
>El mié, 27-08-2003 a las 00:29, Diego Calleja García escribió:
>
>> > - it's easy to use ALSA even when it's not inside the kernel
>> > - within a few months 2.6.0 will be released with ALSA included -
>> >   together with the point above I don't see a reason why ALSA would be
>> >   badly needed in 2.4
>> 
>> Those are valid points. Still I'd love to see ALSA in 2.4. I guess this is a
>> matter of opinion....the VM bits from Andrea are far more important (I've read
>> several bug reports from people who can't get big machines working ie: kswapd decides
>> to take all the cpu for 1 minute)
>
>I think VM are more important that any other things at this moment, but
>is not the only thing to take care of.

yes, it is more important the possible changes in the VM.

>From my small point of view we consider this:

ALSA: is very easy to configure it outside the kernel tree, without patching it.

I2C 2.8.0: (the same happens with alsa FIXME) (discussed in another thread).

XFS: the XFS needs yes or yes to patch kernel, is used enough in many instalations,
but as consequence modifies several archives of kernel, which does difficult to be able
to include some patch more after this, like for example some of security (lids, etc...).

Conclusion: I vote by VM (priority) and XFS.

chau,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
