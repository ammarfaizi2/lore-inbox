Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278702AbRJXSZQ>; Wed, 24 Oct 2001 14:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278703AbRJXSZF>; Wed, 24 Oct 2001 14:25:05 -0400
Received: from pop3.telenet-ops.be ([195.130.132.40]:25266 "EHLO
	pop3.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S278702AbRJXSYt>; Wed, 24 Oct 2001 14:24:49 -0400
Date: Wed, 24 Oct 2001 20:25:18 +0200
From: Sven Vermeulen <sven.vermeulen@rug.ac.be>
To: Linux-Kernel Development Mailinglist 
	<linux-kernel@vger.kernel.org>
Cc: Karsten Keil <keil@isdn4linux.de>
Subject: Re: 2.4.13: some compilerwarnings...
Message-ID: <20011024202518.A552@Zenith.starcenter>
Mail-Followup-To: Linux-Kernel Development Mailinglist <linux-kernel@vger.kernel.org>,
	Karsten Keil <keil@isdn4linux.de>
In-Reply-To: <20011024195342.A464@Zenith.starcenter> <Pine.LNX.4.30.0110242003430.19308-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0110242003430.19308-100000@Appserv.suse.de>; from davej@suse.de on Wed, Oct 24, 2001 at 08:07:42PM +0200
X-Operating-System: Linux 2.4.13
X-Telephone: +32 486 460306
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2001 at 08:07:42PM +0200, Dave Jones wrote:
[ About md5sum warnings about incorrect md5sum's ]
> Been there for a while, and should be harmless.
> If you really cared, you could add the new md5sums to the script
> that does the checking. 

Can't do that. Those md5sum's are there for a reason.

In $LINUXSOURCE/Documentation/isdn/HiSax.cert :

[...]
  If you change the main files of the HiSax ISDN stack, the certification
  will become invalid. Because in most countries it is illegal to connect
  unapproved ISDN equipment to the public network, I have to guarantee that
  changes in HiSax do not affect the certification.

  In order to make a valid certification apparent to the user, I have built
  in some validation checks that are made during the make process. The HiSax
  main files are protected by md5 checksums and the md5sum file is pgp
  signed by myself:
[...]

	Sven Vermeulen
-- 
I develop for Linux for a living, I used to develop for DOS. Going from
DOS to Linux is like trading a glider for an F117. ~(Lawrence Foard)

