Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262686AbVA0Rs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbVA0Rs1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 12:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbVA0RoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 12:44:12 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:39626 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262679AbVA0Rlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 12:41:45 -0500
Message-ID: <41F927F2.2080100@comcast.net>
Date: Thu, 27 Jan 2005 12:42:10 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@infradead.org>
CC: Julien TINNES <julien.tinnes.NOSPAM@francetelecom.REMOVE.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Patch 0/6  virtual address space randomisation
References: <20050127101117.GA9760@infradead.org>	 <41F8D44D.9070409@francetelecom.REMOVE.com> <1106827050.5624.81.camel@laptopd505.fenrus.org>
In-Reply-To: <1106827050.5624.81.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Arjan van de Ven wrote:
> On Thu, 2005-01-27 at 12:45 +0100, Julien TINNES wrote:
> 
>>Arjan van de Ven wrote:
>>
>>>The randomisation patch series introduces infrastructure and functionality
>>>that causes certain parts of a process' virtual address space to be
>>>different for each invocation of the process. The purpose of this is to
>>>raise the bar on buffer overflow exploits; full randomisation makes it not
>>>possible to use absolute addresses in the exploit.
>>>
>>
>>I think it is worth mentioning that this is part of PaX ASLR, but with 
>>some changes and simplification.
> 
> 
> it actually came from Exec-Shield not PaX
> 

Yeah, if it came from PaX the randomization would actually be useful.
Sorry, I've just woken up and already explained in another post.

[...]

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB+SfwhDd4aOud5P8RArzvAJ91+7oeFvQyhfH5ovHkkWG7FQcazgCfchDA
4lxXXLmMA5PcZuICxoxnQGU=
=oXcE
-----END PGP SIGNATURE-----
