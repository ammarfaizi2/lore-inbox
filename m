Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbVJFKpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbVJFKpY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 06:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbVJFKpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 06:45:23 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:30025 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S1750819AbVJFKpW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 06:45:22 -0400
DomainKey-Signature: a=rsa-sha1; b=WqEyraO/7u5LCSHc8pV0B4xgI+kzGFkAdhCOP3yOSNasOXcQeSFcUnUB2wVN5UFFnodOryZne3tExSVvzYkalcswurIxmwgUc24APpGM8ANVmleXQQm3LLMlisIfJkJBru8FT7FRS/4/4uPCp78/HrBMbUyvy11715iIUIc81bw=; c=nofws; d=rudy.mif.pg.gda.pl; q=dns; s=prime
Date: Thu, 6 Oct 2005 12:45:17 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: grundig@teleline.es
cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, leimy2k@gmail.com,
       7eggert@gmx.de, nix@esperi.org.uk, marc@perkel.com,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
In-Reply-To: <20051006115339.6fd736a0.grundig@teleline.es>
Message-ID: <Pine.BSO.4.62.0510061237310.28198@rudy.mif.pg.gda.pl>
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it>
 <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix>
 <3e1162e60510050755l590a696bx655eb0b7ac05aab6@mail.gmail.com>
 <Pine.LNX.4.58.0510051744480.2279@be1.lrz> <3e1162e60510050941l55485cbdgf6135e314a015d8f@mail.gmail.com>
 <20051005232330.GS10538@lkcl.net> <20051006115339.6fd736a0.grundig@teleline.es>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-202644770-1128595517=:28198"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-202644770-1128595517=:28198
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 6 Oct 2005 grundig@teleline.es wrote:

> El Thu, 6 Oct 2005 00:23:30 +0100,
> Luke Kenneth Casson Leighton <lkcl@lkcl.net> escribió:
>
>>  there are a lot of legacy apps that no-one wants to modify to get them
>>  to create/read /tmp/x-windows/.X11-unix.
>
> What's the point of caring about security for a legacy app if nobody
> is going to fix it if a security problema arises?
>
>
> http://packages.debian.org/unstable/admin/libpam-tmpdir
>
> is good enought IMO

BTW. Also it will be good say something about storing unix sockets by 
system programs (/tmp/x-windows/.X11-unix which is owned by root.root) in 
/tmp.

http://www.pathname.com/fhs/pub/fhs-2.3.html#REQUIREMENTS14
says about /var/run:
"System programs that maintain transient UNIX-domain sockets must place 
them in this directory."

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-202644770-1128595517=:28198--
