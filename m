Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272677AbRIGOkz>; Fri, 7 Sep 2001 10:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272679AbRIGOkf>; Fri, 7 Sep 2001 10:40:35 -0400
Received: from pop1.netcis.com ([199.227.10.105]:37504 "HELO pop1.netcis.com")
	by vger.kernel.org with SMTP id <S272681AbRIGOk2>;
	Fri, 7 Sep 2001 10:40:28 -0400
Date: Fri, 7 Sep 2001 10:34:07 -0700
From: Jeremiah Johnson <miah@netcis.com>
X-Mailer: The Bat! (v1.53d)
Reply-To: Jeremiah Johnson <miah@netcis.com>
Organization: NETCIS International Corporation
X-Priority: 3 (Normal)
Message-ID: <8638021391.20010907103407@netcis.com>
To: volodya@mindspring.com
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re[6]: 2.4.9 UDP broke?
In-Reply-To: <Pine.LNX.4.20.0109051626440.25127-100000@node2.localnet.net>
In-Reply-To: <Pine.LNX.4.20.0109051626440.25127-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: MD5

Hello volodya,

If I enable both of these options though, UDP totally breaks for me.
So its definitely something in there.  Maybe I'll get some time and
test to see which option is actually doing the breaking.

Wednesday, September 05, 2001, 1:28:39 PM, you wrote:

vmc> On Tue, 4 Sep 2001, Jeremiah Johnson wrote:

>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: MD5
>>
>> Hello volodya,
>>
>> I found the answer to the problem today.  It has to do with a bug in
>> one of these options:
>>
>> CONFIG_TULIP_MWI
>> CONFIG_TULIP_MMIO
>>

vmc> You are absolutely correct - once I enabled both of these it works
vmc> great. My guess is that whoever tested the patches was concentrated on the
vmc> case when options were enabled.

vmc>                                Vladimir Dergachev

- --
Best regards,
 Jeremiah                            mailto:miah@netcis.com

-----BEGIN PGP SIGNATURE-----
Version: 2.6

iQEVAwUAO5kFFJHTj7BlqKb5AQG+9ggAnKz03bYjsYYSsrINzUTKEFCtWs2bRP0t
sGsIZ55rpi4FH9QFbJGIzxih6C5Mf3p1IJU2fUEP5ci4ddEDJbWbAia/4yz6S2qd
hAe3pjep/Oy1XBky8PKxIpLkOJMAgFgqeM9aguwFVCuhXxZBvK6NNPaozqZ/nYHl
9EM8/kuwfNONaJxYnduqkCRPKdCUPxPZcuwd56Wt3JvJ6meUW249pGEBJhFM63Qe
+esn3TweBeYj5M80mYcU0CunDRr3D0ABMrdtApCUv0FMIP7ke0LTCQBeZZrUtajW
+k/gDEySN3tRIuCUltYZ5SYMxtxFZ6eYgerwyhr3s8iKfD+7Tk1BFg==
=/5Uc
-----END PGP SIGNATURE-----

