Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVG1Dxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVG1Dxd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 23:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVG1Dxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 23:53:33 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:39821 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261283AbVG1Dv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 23:51:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.br;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:X-Enigmail-Version:X-Enigmail-Supports:Content-Type:Content-Transfer-Encoding;
  b=4PBUeSPLpFiGJvbh2gSrgd77T/A+Rq5YJghysAhhZl8DSeYgruPl/a2g3MCII4P2oOjGRjt+5TLiYMRHGs9UxYpv/F9ov26SO7xq7X3CsTvDrIc9jax1b8cAWA8vg7MfwYmDngNyf/QQONAy0MUWKcpZa2dM1iVaTupHwnHmMgM=  ;
Message-ID: <42E85E6E.2020105@yahoo.com.br>
Date: Thu, 28 Jul 2005 01:26:22 -0300
From: "Francisco Figueiredo Jr." <fxjrlists@yahoo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: "seeing minute plus hangs during boot" - 2.6.12 and 2.6.13
References: <20050722182848.8028.qmail@web60715.mail.yahoo.com>	<105c793f05072507426fb6d4c9@mail.gmail.com>	<42E59E0E.5030306@yahoo.com.br>	<20050726003322.1bfe17ee.akpm@osdl.org>	<42E7A153.6060307@yahoo.com.br> <20050727105005.30768fe3.akpm@osdl.org>
In-Reply-To: <20050727105005.30768fe3.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton wrote:
>>>
>>
>>
>>Hi Andrew.
>>I was not able to get anything when I press this key sequence.
>>
>>I checked my sysrq key with showkey -s as this doc
>>(http://snafu.freedom.org/linux2.2/docs/sysrq.txt) says and I could
>>confirm that alt+sysrq is sending 0x54.
>>
>>I also noted that many said that this option has to be compiled in
>>kernel, but I couldn't find this option.
>>
>>Can you give me some tips?
>>
> 
> 
> (Please leave the cc list unchanged - always do reply-to-all)
> 
> hm, maybe do alt-sysrq-7 to make sure that the loglevel is appropriately set.
> 
> Or do alt-sysrq-B to test that the whole sysrq thing is working.  If it is,
> that will reboot the machine.
> 
> 


Ok, nevermind. I just found that I didn't add the sysrq support when
compiling my kernel :(

I will recompile it and send you stack trace.

Sorry for wasting your time, Andrew.


- --
Regards,

Francisco Figueiredo Jr.
Npgsql Lead Developer
http://gborg.postgresql.org/project/npgsql
MonoBrasil Project Founder Member
http://monobrasil.softwarelivre.org


- -------------
"Science without religion is lame;
religion without science is blind."

                  ~ Albert Einstein
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQEVAwUBQuhebv7iFmsNzeXfAQKovAf+IytBAXybpV102ATXL6lDrNKCwy9QsmWH
ntUv9+JLeIKbuzKJFn2gu3ftLW5dwiXq2fL0aRg5NGk9K32pCGcE43LEyZ+dglG9
FWBNV47iB4NxOLh7YfKrOf7wT3eRs4Qwfm9TZn5segJn0MExd9kHuYgJ1hO/ZUzF
OksF5hAusjTM7dLA2LwX7mUOMs8VFPqRuEufCQ/TOCiPhxzoZJ6XFbkJ3ZHwqJ9m
jZwfHihz2n0NiBWu0vNGBS2EjS3U2URphV0fhCAt/pILAk1kQvEAsXBo0vgFwsfg
dYSjubVnPffACPFZZsNvjUBFf6tQ32+t1vVFDHD1ym2wq/4z87+5pw==
=nG/V
-----END PGP SIGNATURE-----

	
	
		
_______________________________________________________ 
Yahoo! Acesso Grátis - Internet rápida e grátis. 
Instale o discador agora! http://br.acesso.yahoo.com/
