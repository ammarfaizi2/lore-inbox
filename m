Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSDIMQI>; Tue, 9 Apr 2002 08:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313868AbSDIMQH>; Tue, 9 Apr 2002 08:16:07 -0400
Received: from firewall.unidec.co.uk ([195.166.19.2]:42552 "EHLO
	firewall.unidec.co.uk") by vger.kernel.org with ESMTP
	id <S313867AbSDIMQH>; Tue, 9 Apr 2002 08:16:07 -0400
Message-Id: <200204091216.g39CG5Q31094@frumious.unidec.co.uk>
Content-Type: text/plain; charset=US-ASCII
From: dr john halewood <john@frumious.unidec.co.uk>
Organization: unidentified sloths
To: linux-kernel@vger.kernel.org
Subject: Re: Compaq Alpha DS10 - Kernel 2.4.18
Date: Tue, 9 Apr 2002 12:16:05 +0000
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <000d01c1dfb0$0da74a30$010b10ac@sbp.uptime.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 April 2002 11:19 am, Oliver Pitzeier wrote:
> Hi all!
> [...]
> OK, I did so... fsck -y /dev/sda1 -> Works perfectly. After
> fsck has corrected more than 1000 errors I'm able to
> reboot the machine.
>
> And than: MY SYSTEM IS NO LONGER BOOTABLE. It's totally
> currupted...
> Are there any alpha-users in this list? :o))))
$uname -a
Linux frumious.unidec.co.uk 2.4.19pre1 #2 Wed Feb 27 14:45:16 GMT 2002 alpha 
unknown

Yup.  Not had any problems despite a series of recent powercuts (including 
one where the mains voltage dropped from ~230V to ~150V), but did have very 
long fsck()s afterwards. So I gave up and went to ext3 - all it takes is 
kernel support and a quick tune2fs -j /dev/XXX ;-)

cheers
john
