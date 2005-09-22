Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbVIVGzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbVIVGzy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 02:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbVIVGzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 02:55:54 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:56999 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932153AbVIVGzx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 02:55:53 -0400
Message-ID: <43325568.8080107@us.ibm.com>
Date: Wed, 21 Sep 2005 23:55:36 -0700
From: Ian Romanick <idr@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rep stsb <repstsb@yahoo.ca>
CC: linux-kernel@vger.kernel.org, 06020051@lums.edu.pk
Subject: Re: In-kernel graphics subsystem
References: <20050922055120.23356.qmail@web33203.mail.mud.yahoo.com>
In-Reply-To: <20050922055120.23356.qmail@web33203.mail.mud.yahoo.com>
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=AC84030F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

rep stsb wrote:
> Athar Hameed wrote: 
> 
>>We are a group of three undergrad CS students, 
>>almost ready to start our senior project. We have
>>this idea of integrating a graphics subsystem with
>>the kernel
> 
> A thread about getting vertical synchronization
> interrupts from a video card is available at, 

This functionality is already exposed by the DRM for several cards.
Since work is happening on the X side of things (i.e., EXA) that will
make having a DRM for even non-3D cards desireable, this is probably a
better route to go.

Either that or extend the existing fb drivers.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFDMlVoX1gOwKyEAw8RAgvzAJ41K9u5LQ7GTNe7qfBrWY61+bI32wCeMHIH
z4f5g5uzAIgYixVRpQAqZJI=
=CYVB
-----END PGP SIGNATURE-----
