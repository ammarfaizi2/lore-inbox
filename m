Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263759AbUC3RGF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 12:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263754AbUC3RGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 12:06:03 -0500
Received: from smtp-out5.xs4all.nl ([194.109.24.6]:40709 "EHLO
	smtp-out5.xs4all.nl") by vger.kernel.org with ESMTP id S263760AbUC3RFT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 12:05:19 -0500
In-Reply-To: <20040330130942.GC3084@openzaurus.ucw.cz>
References: <1079446776784@twilight.ucw.cz> <10794467761141@twilight.ucw.cz> <20040327195535.GA11610@wsdw14.win.tue.nl> <20040330130942.GC3084@openzaurus.ucw.cz>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-53--720111191"
Message-Id: <63211B64-826C-11D8-81D2-000A95CD704C@wagland.net>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Vojtech Pavlik <vojtech@suse.cz>, Andries Brouwer <aebr@win.tue.nl>,
       vojtech@ucw.cz
From: Paul Wagland <paul@wagland.net>
Subject: Re: [PATCH 9/44] Support for scroll wheel on Office keyboards
Date: Tue, 30 Mar 2004 19:05:03 +0200
To: Pavel Machek <pavel@suse.cz>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-53--720111191
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Mar 30, 2004, at 15:09, Pavel Machek wrote:

> Hi!
>
>> Apart from this concrete question - the number of keyboards and
>> mice is very large and growing by the day. I think it is hopeless
>> to try and teach the kernel about all details of each of them.
>> I think we should try to go for a keyboard/mouse definition file
>> maintained in user space and fed to the kernel.
>
> Well, if it can be maintained in userspace, it should be possible to 
> maintain, too.
> Plus it seems to me that some keyboards are compatible with others... 
> for example arima
> seems to generate same keycodes for "vol+" and "vol-" as compaq 
> nx5000...

Sure, it is possible to keep up, but if something is constantly 
updating then surely it is better to put that in userspace? That way if 
I buy a new (not currently supported) keyboard, all as I have to do is 
to update the userspace text file, and everything works. If it is in 
the kernel, then I have to upgrade my kernel, and for many users, this 
is not a trivial task. Indeed, for many users this then causes support 
issues (think enterprise distributions).

Just my thoughts,
Paul

--Apple-Mail-53--720111191
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFAaajDtch0EvEFvxURApkkAJ9i9Obb8nJWhSUvtsxtBJS5c+0dKQCfZLHj
kXvipXxZIrCTC7Gc7/uBfCQ=
=xDIr
-----END PGP SIGNATURE-----

--Apple-Mail-53--720111191--

