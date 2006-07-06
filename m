Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWGFVkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWGFVkk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 17:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWGFVkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 17:40:40 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:61117 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750782AbWGFVkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 17:40:39 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: Driver for Microsoft USB Fingerprint Reader
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux@horizon.com,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Thu, 06 Jul 2006 23:39:44 +0200
References: <6vtYr-w2-5@gated-at.bofh.it> <6vFQ5-1iV-71@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1FybZs-0000e5-5K@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Iau, 2006-07-06 am 00:48 -0400, ysgrifennodd linux@horizon.com:

>> As far as I can tell, the only thing you want is AUTHENTICATION - you
>> want proof that you are getting a "live" scan taken from a user
>> who's present, and not a replay of what was sent last week.
> 
> Read the papers on the subject. If I can get copies of the unencrypted
> data I can use those to make fake fingers.

Copies like the one on the glass I used in the restaurant ...

> A finger print is personal data, arguably sensitive personal data. That
> means there are lots of duties to store it securely.

That's why every waiter will assiduously clean your glass. won't he?

> It is also very
> hard to revoke a fingerprint so theft of data is highly problematic as
> it will allow me to generate fake fingers.

That's the problem: You can't know who is acting responsibly and who isn't.
Therefore you can't reuse your fingerprint on different sites.

> Theft of encrypted data might
> allow replay attacks on one PC. Big deal.

ACK. It should be protected by a nonce, too, as long as you depend on
encryption. You should also authenticate the reader before prompting for
a fingerprint, otherwise the replacement device might store the image to a
secondary location. And don't forget to prompt for cleaning the scanner, I
have heared rumors about scanners erroneously authenticating the previous
user. You should also install a camera preventing an attacker to place his
own scanner on top of yours.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
