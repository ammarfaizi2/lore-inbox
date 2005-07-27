Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262260AbVG0OZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbVG0OZY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 10:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbVG0OZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 10:25:17 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:39546 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262260AbVG0OZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 10:25:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.br;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:X-Enigmail-Version:X-Enigmail-Supports:Content-Type:Content-Transfer-Encoding;
  b=jOO8ISjCetprpDtwoBlIn8iQSC3ibCvKEdK40JqPJsKUuO4df5DRnsdEQx3gJmQDxVg+8IZJWDRM9WYsEu3yUoZl0Ybgf7wWtpQcx+TyStkl/xY8senQqunNMeJigcJ1qldriqk2XD1S7r2E4KtGRMdlFCVHw4jxOXpp5Pvk+eo=  ;
Message-ID: <42E7A153.6060307@yahoo.com.br>
Date: Wed, 27 Jul 2005 11:59:31 -0300
From: "Francisco Figueiredo Jr." <fxjrlists@yahoo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: "seeing minute plus hangs during boot" - 2.6.12 and 2.6.13
References: <20050722182848.8028.qmail@web60715.mail.yahoo.com>	<105c793f05072507426fb6d4c9@mail.gmail.com>	<42E59E0E.5030306@yahoo.com.br> <20050726003322.1bfe17ee.akpm@osdl.org>
In-Reply-To: <20050726003322.1bfe17ee.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton wrote:
> "Francisco Figueiredo Jr." <fxjrlists@yahoo.com.br> wrote:
> 
>>Indeed udev update solved my problem with "preparing system to use udev"
>> hang. It now works like a charm. I had 030 version too.
>>
>> Only the "mounting filesystem" hangs persists :(
> 
> 
> Please use ALT-SYSRQ-T to generate an all-task backtrace, then send it to the
> list.
> 


Hi Andrew.
I was not able to get anything when I press this key sequence.

I checked my sysrq key with showkey -s as this doc
(http://snafu.freedom.org/linux2.2/docs/sysrq.txt) says and I could
confirm that alt+sysrq is sending 0x54.

I also noted that many said that this option has to be compiled in
kernel, but I couldn't find this option.

Can you give me some tips?

Thanks in advance.


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

iQEVAwUBQuehU/7iFmsNzeXfAQJbwAgAnlu+IG3R1N5lgcs0lMMbXEx98HQ4uFGe
XucX6so0ncZh8n0Y0jSpBJNniFtdY0WCV8ferUrYjYiflgP+0LtWbW398yjicJ2P
wvRoVplzLH3L5/cIPd5HzFjhBzwKAcveMJrwcV6TZmCH/cCzd13MhrhpkcqunWez
9RG30xffKTeOyleqbsceTeGmge+tvNw07knU0jcyuo9Fa7n9FD4yMoxabk0BibZM
TL001SqqtUKSeyog9kG80Ub6AeAYSVQtD5HV4/AQVXPxyG0SN0X18Umf2EF1X7Px
m1v2yMeTmhtgpXzwRCgg+TkS7y/RbOfBHhoUliYvuqFSLFSey9g7SA==
=cpAL
-----END PGP SIGNATURE-----

	
	
		
_______________________________________________________ 
Yahoo! Acesso Grátis - Internet rápida e grátis. 
Instale o discador agora! http://br.acesso.yahoo.com/
