Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266678AbUBLXVO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 18:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266681AbUBLXVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 18:21:14 -0500
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:24195 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266678AbUBLXVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 18:21:09 -0500
Message-ID: <402C0A4D.60102@yahoo.es>
Date: Thu, 12 Feb 2004 18:20:45 -0500
From: Roberto Sanchez <rcsanchez97@yahoo.es>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6, 2.4, Nforce2, Experimental idle halt workaround
 instead of apic ack delay.
References: <200402120122.06362.ross@datscreative.com.au> <Pine.LNX.4.58.0402121118490.515@gonopodium.signalmarketing.com> <20040212214407.GA865@tesore.local> <Pine.LNX.4.58.0402121544470.962@gonopodium.signalmarketing.com> <1076623565.16585.11.camel@athlonxp.bradney.info> <20040212230456.GA911@tesore.local>
In-Reply-To: <20040212230456.GA911@tesore.local>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig14D49DB449D527A1DED68AFF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig14D49DB449D527A1DED68AFF
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jesse Allen wrote:
> On Thu, Feb 12, 2004 at 11:06:05PM +0100, Craig Bradney wrote:
> 
> 
>>so what does "My
>>Shuttle AN35N nforce2 board can run vanilla kernels with the 12-5-2003
>>dated bios version and not lock up." mean?
>>
> 
> 
> vanilla kernels = 2.6.0-test11 through 2.6.3-rc2 and no patches.  APIC is on.
> 
> 12-5-2003 BIOS:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107124823504332&w=2
> 
> not lock up:
> I could reproduce the lockup consistantly.  With the 12-5-2003 bios, I cannot.  Two months have passed since the original report.
> 
> 
>>Whenthis thread first(?) started way back when in Nov or Dec last year I
>>was pretty happy.. no lockups until the 5th day.
> 
> 
> The different nforce boards react differently because of different hardware an 
> manufacterers.  But they all do have a common symptom.  
> 
> I don't know how to identify a fix from my bioses.  If someone has any clue, I 
> will help out.
> 

FWIW, my Biostar M7NCDPro with the latest (12-08-2003) BIOS locks up
consistently unless I disable APIC (either in the kernel or the BIOS)
or apply some sort of patch (like the APIC and disconnect-quirk patches
that briefly made the rounds in the -mm tree).

-Roberto Sanchez

--------------enig14D49DB449D527A1DED68AFF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFALApNTfhoonTOp2oRAjlgAJ9kVECSjnkMKDdhU+vcmclLEjLnUgCffgj5
Okhat6ONj9E8prBGYUGHOMk=
=W6Ak
-----END PGP SIGNATURE-----

--------------enig14D49DB449D527A1DED68AFF--
