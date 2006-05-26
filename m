Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWEZLaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWEZLaJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 07:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWEZLaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 07:30:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:36119 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932294AbWEZLaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:30:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=G9296kxNpjSsfSixUwQSzaFDZ0NGtRmHDzbTAGA1FozXZ58UbQEdzFI5J41HHH5h9I8ShylFuCkQcyZ7aV7kKF3ItItV2iZjpHuf0E+jnKZNKvKetjqVEc7li5maCtkLy+0hx3je4eB1td7Z/Th8gOtVxKJjsefAloZHFNHfz0k=
Message-ID: <4476E69F.6020502@gmail.com>
Date: Fri, 26 May 2006 13:29:12 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, netdev@vger.kernel.org,
       mb@bu3sch.de, st3@riseup.net, linville@tuxdriver.com
Subject: Re: [PATCH 2/3] pci: bcm43xx avoid pci_find_device
References: <20060526001053.D2349C7C58@atrey.karlin.mff.cuni.cz> <44764D4B.6050105@pobox.com> <4476D63E.8090207@gmail.com> <4476D6EC.4060501@pobox.com> <4476D95B.5030601@gmail.com> <4476DA5C.9080602@pobox.com> <4476DE47.7010907@gmail.com> <4476E203.1080701@pobox.com>
In-Reply-To: <4476E203.1080701@pobox.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeff Garzik napsal(a):
> Jiri Slaby wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Jeff Garzik napsal(a):
>>> The point is that you don't need to loop over the table,
>>> pci_match_one_device() does that for you.
>> The problem is, that there is no such function, I think.
>> If you take a look at pci_dev_present:
> 
> The function you want is pci_dev_present().
Nope, it returns only 0/1.

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEduafMsxVwznUen4RAjfzAKCaxRAK1nN5qx+akiA59E5Mq/ZPcgCffRwa
vwAz0SPClr6sCYy+DOjtilE=
=DHzA
-----END PGP SIGNATURE-----
