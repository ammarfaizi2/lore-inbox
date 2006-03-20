Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbWCTQUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbWCTQUS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWCTQUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:20:17 -0500
Received: from orfeus.profiwh.com ([82.100.20.117]:34575 "EHLO
	orfeus.profiwh.com") by vger.kernel.org with ESMTP id S964923AbWCTQUP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:20:15 -0500
Message-ID: <441ED656.7050005@gmail.com>
Date: Mon, 20 Mar 2006 17:20:15 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Xavier Bestel <xavier.bestel@free.fr>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Li Yang-r58472 <LeoLi@freescale.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Lindent and coding style
References: <9FCDBA58F226D911B202000BDBAD4673054C311B@zch01exm40.ap.freescale.net>	 <1142865404.20050.29.camel@localhost.localdomain>	 <441EC157.2030103@gmail.com> <1142871150.22772.351.camel@capoeira>
In-Reply-To: <1142871150.22772.351.camel@capoeira>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
X-SpamReason: {}-{0,00}-{0,00}-{0,00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Xavier Bestel napsal(a):
> On Mon, 2006-03-20 at 15:51, Jiri Slaby wrote:
>>> It should produce suitable output. Do you have examples of where it
>>> produces space indentation and you expect tabs ?
>> As far as I know, it produces:
>> <tab>	if (very long condition &&
>> <tab>   ssss2nd condition)...
>> where ssss are four spaces. Maybe this is considered as well formed at all, but
>> I indent 3 tabs in this case.
> 
> Does that mean your tabs are 2-chars wide ? I think Linus stated that
> tabs should be 8-chars wide, that should be somewhere in the
> CodingStyle.
Nope, you maybe misunderstood me. Tab is 8 chars wide, but lindent do 4 spaces
on line after `if' if the condition continues on the next line. Then, I wrote I
do 2 tabs (16 chars) instead of 4-lindent spaces.

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEHtZWMsxVwznUen4RAv5gAJ9Q14Us1CCO3k+FoNWWgfDNYRzY4gCgt7jg
HKphoxhtCeUYU/l2mNg4TIY=
=P1Gq
-----END PGP SIGNATURE-----
