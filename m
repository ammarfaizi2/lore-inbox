Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUAKTqc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 14:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265974AbUAKTqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 14:46:32 -0500
Received: from adsl-68-78-203-130.dsl.klmzmi.ameritech.net ([68.78.203.130]:56328
	"EHLO mail.domedata.com") by vger.kernel.org with ESMTP
	id S265973AbUAKTqa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 14:46:30 -0500
From: tabris <tabris@tabris.net>
To: "Hunt, Adam" <ahunt@solvone.com>
Subject: Re: SecuriKey
Date: Sun, 11 Jan 2004 14:46:25 -0500
User-Agent: KMail/1.5.3
References: <5117BFF0551DD64884B32EE8CA57D3DB01548A3F@revere.nwpump.com>
In-Reply-To: <5117BFF0551DD64884B32EE8CA57D3DB01548A3F@revere.nwpump.com>
Cc: <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200401111446.27403.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 11 January 2004 10:44 am, Hunt, Adam wrote:
> Does anyone know anything about SecuriKey devices (www.securikey.com)? 
> They are a little USB fob that looks kind of like a pen drive.  I
> assume they are just some type of one-time-pad generator but don't have
> one to play with.  This sounds like the perfect device to implement as
> a LSM.
>
> --adam
> -

	How do you generate a one-time-pad? a one time pad must be by definition 
truly random, and be used only once. and if you can send the Securikey 
via a secure channel at the same time as the message, then you don't need 
the OTP.

	I should also mention that the problem with 'generating' an OTP via any 
mechanical or algorithmic means is impossible as at best an OTP will only 
be pseudo-random, and therefore with identical inputs (assuming it is 
possible, which we can assume here for the sake of theory and security), 
the same OTP can be generated, thus breaking our assumption/necessity of 
non-deterministic output.

	I'd say more but I'm on my way to work.
- --
tabris
- -
I do not know whether I was then a man dreaming I was a butterfly, or
whether I am now a butterfly dreaming I am a man.
		-- Chuang-tzu
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAAagR1U5ZaPMbKQcRAmo2AJ0Wc6xTLCd/swZYlEO6emktLhOtRgCfUUP5
OB4YFi6bh1yrVMzGIoN6XNs=
=O/uT
-----END PGP SIGNATURE-----

