Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262189AbRENDE3>; Sun, 13 May 2001 23:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262229AbRENDES>; Sun, 13 May 2001 23:04:18 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:43018 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S262189AbRENDEB>; Sun, 13 May 2001 23:04:01 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
cc: "Mike A. Harris" <mharris@opensourceadvocate.org>,
        Hacksaw <hacksaw@hacksaw.org>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Message-ID: <86256A4C.0010B683.00@smtpnotes.altec.com>
Date: Sun, 13 May 2001 21:59:07 -0500
Subject: Re: Not a typewriter
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/13/2001 at 08:03:30 PM Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
wrote:

>The old C compiler/old Unix linker guaranteed 6 chars in an external symbol
>name only, and C functions got an underscore prepended: _creat. I guess
>this is the reason for this wart. As to why 6 chars only, I'd guess some
>data structure in the linker was laid out that way. Machines had a few
>dozen Kbs of RAM then, space was precious.

I've always thought it was just an arbitrary decision, based on the general Unix
custom of shortnening names by removing vowels, especially since Ken Thompson
later said he'd spell it "create" if he had it to do over again.  But your
explanation sounds more likely.  I really should have thought of this, since I
used to run into problems with non-unique names under the Minix linker (which,
IIRC, had the same 6 char limit).


