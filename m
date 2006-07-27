Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWG0Mey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWG0Mey (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 08:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWG0Mey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 08:34:54 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:24802 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750720AbWG0Mey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 08:34:54 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: Can we ignore errors in mcelog if the server is running fine
To: Vikas Kedia <kedia.vikas@gmail.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Thu, 27 Jul 2006 14:34:02 +0200
References: <6Dc4C-1tt-47@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1G654J-0001B7-55@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vikas Kedia <kedia.vikas@gmail.com> wrote:

> The server seems to be running fine.

Since these errors were corrected, you should expect that.

> A. can I ignore the following
> mcelog errors ?

Obviously, but I doubt you want to.

> B. If not what should i do to stop the server from
> reporting mcelog errors.

Fix the problem.

> CPU 0 0 data cache TSC 997fa760e9
> ADDR 2c13340
>   Data cache ECC error (syndrome e3)
>        bit46 = corrected ecc error

It's reported to be the data cache on CPU 0. You'll need to replace that
part of the cache (and the rest of the CPU, since you can't buy spare
cache lines nor that small soldering irons.-) The old CPU will be fine for
unimportant machines.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
