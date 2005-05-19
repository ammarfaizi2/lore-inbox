Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262469AbVESIiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbVESIiv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 04:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbVESIiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 04:38:51 -0400
Received: from tassadar.physics.auth.gr ([155.207.123.25]:15536 "EHLO
	tassadar.physics.auth.gr") by vger.kernel.org with ESMTP
	id S262469AbVESIir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 04:38:47 -0400
Date: Thu, 19 May 2005 11:38:37 +0300 (EEST)
From: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
To: ted creedon <tcreedon@easystreet.com>
cc: openafs-info@openafs.org, linux-kernel@vger.kernel.org
Subject: RE: [OpenAFS] Re: Openafs 1.3.78 and kernel 2.4.29 oopses , same
 for 2.4.30 and openafs 1.3.82
In-Reply-To: <20050512140505.6574EB01E@smtpauth.easystreet.com>
Message-ID: <Pine.LNX.4.62.0505191135590.32055@tassadar.physics.auth.gr>
References: <20050512140505.6574EB01E@smtpauth.easystreet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-AntiVirus: checked by AntiVir Milter (version: 1.1.0-4; AVE: 6.30.0.12; VDF: 6.30.0.183; host: tassadar)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Dimitris,
>
> Glad to be of help. Send a response to the mailing list after a week or so
> of operation.
>
> This is a very important step and not documented.
>
> ted
>
> -----Original Message-----
> From: Dimitris Zilaskos [mailto:dzila@tassadar.physics.auth.gr]
> Sent: Wednesday, May 11, 2005 10:07 PM
> To: ted creedon
> Cc: openafs-info@openafs.org; linux-kernel@vger.kernel.org
> Subject: RE: [OpenAFS] Re: Openafs 1.3.78 and kernel 2.4.29 oopses , same
> for 2.4.30 and openafs 1.3.82
>
> On Mon, 9 May 2005, ted creedon wrote:
>
>> Looks like a compile problem if there's a symbol table error.
>>
>> To eliminate that as a cause:
>> Make bzImage;make modules;make modules_install;make install; Reboot
>> into the new image Run regen.sh then ./configure and built a new
>> openafs system; install ane test it.
>>
>> I think there may be small differences in the m4 macros between
>> various operating systems.
>>
>> This is the only way I can get reliable compiles. I have had one
>> server crash with 1.3.81 but I suspect the software raid filesystem.
>>

 	It's been 9 days now of heavy usage , and not a single oops 
occured again. Problem solved:)


Best regards ,


--
=============================================================================

Dimitris Zilaskos

Department of Physics @ Aristotle University of Thessaloniki , Greece
PGP key : http://tassadar.physics.auth.gr/~dzila/pgp_public_key.asc
 	  http://egnatia.ee.auth.gr/~dzila/pgp_public_key.asc
MD5sum  : de2bd8f73d545f0e4caf3096894ad83f  pgp_public_key.asc
=============================================================================


