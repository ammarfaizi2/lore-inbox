Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031665AbWLARdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031665AbWLARdO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 12:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031664AbWLARdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 12:33:13 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:42981 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1031660AbWLARdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 12:33:11 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: [RFC][PATCH] Pseudo-random number generator
To: Alan <alan@lxorguk.ukuu.org.uk>, Jan Glauber <jan.glauber@de.ibm.com>,
       linux-crypto <linux-crypto@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Fri, 01 Dec 2006 18:33:01 +0100
References: <7ngD0-8fX-11@gated-at.bofh.it> <7ngMA-8D-39@gated-at.bofh.it> <7niv3-4sQ-21@gated-at.bofh.it> <7niEE-4Mk-5@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1GqCFx-0006X8-IO@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@gmx.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan <alan@lxorguk.ukuu.org.uk> wrote:
> On Fri, 01 Dec 2006 16:20:46 +0100
> Jan Glauber <jan.glauber@de.ibm.com> wrote:

>> Yes, a user can just symlink urandom to prandom and will have a faster
>> generator.
> 
> 
> More usefully they can use it as an entropy source with an entropy
> daemon to feed it into the standard urandom/random.

Only if other users will randomly drain /dev/prandom, otherwise you might
as well use /dev/zero.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
