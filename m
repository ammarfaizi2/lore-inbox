Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWCTOun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWCTOun (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 09:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWCTOun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 09:50:43 -0500
Received: from orfeus.profiwh.com ([82.100.20.117]:26386 "EHLO
	orfeus.profiwh.com") by vger.kernel.org with ESMTP id S964826AbWCTOun
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 09:50:43 -0500
Message-ID: <441EC157.2030103@gmail.com>
Date: Mon, 20 Mar 2006 15:50:40 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060210)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Li Yang-r58472 <LeoLi@freescale.com>, linux-kernel@vger.kernel.org
Subject: Re: Lindent and coding style
References: <9FCDBA58F226D911B202000BDBAD4673054C311B@zch01exm40.ap.freescale.net> <1142865404.20050.29.camel@localhost.localdomain>
In-Reply-To: <1142865404.20050.29.camel@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
X-SpamReason: {}-{0,00}-{0,00}-{0,00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Alan Cox napsal(a):
> On Llu, 2006-03-20 at 19:32 +0800, Li Yang-r58472 wrote:
>> There is a lindent script in linux kernel source.  It breaks long
>> lines, but uses space instead of tab as indentation.  However, the
>> codingstyle document also from the kernel source indicates no space is
>> allowed for indentation.  Is there a fix for this problem?  Or the
>> result from lindent(space indentation) is actually allowed in kernel
>> source?  Thanks.
>>
> 
> It should produce suitable output. Do you have examples of where it
> produces space indentation and you expect tabs ?
As far as I know, it produces:
<tab>	if (very long condition &&
<tab>   ssss2nd condition)...
where ssss are four spaces. Maybe this is considered as well formed at all, but
I indent 3 tabs in this case.

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEHsFXMsxVwznUen4RAsGBAJ9wP+y7teZrFQNeNnBDIx0lSfBP+QCguLwx
IAvBdGnkp8Y/Ft9yOH7m3js=
=4zgg
-----END PGP SIGNATURE-----
