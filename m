Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751802AbWD1Use@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbWD1Use (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 16:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWD1Use
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 16:48:34 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:20048 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1751787AbWD1Usd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 16:48:33 -0400
Message-ID: <44527F9B.6040500@tls.msk.ru>
Date: Sat, 29 Apr 2006 00:48:27 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: Arjan van de Ven <arjan@infradead.org>, Ulrich Drepper <drepper@gmail.com>,
       Axelle Apvrille <axelle_apvrille@yahoo.fr>, Nix <nix@esperi.org.uk>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       disec-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for run-timeauthentication
 of binaries
References: <87slo2nn0b.fsf@hades.wkstn.nix> <20060425161139.87285.qmail@web26109.mail.ukl.yahoo.com> <a36005b50604280833k5a811384r5f3a6f92dd707256@mail.gmail.com> <20060428160914.GA31473@sergelap.austin.ibm.com> <1146240670.3126.20.camel@laptopd505.fenrus.org> <20060428162904.GB31473@sergelap.austin.ibm.com>
In-Reply-To: <20060428162904.GB31473@sergelap.austin.ibm.com>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge E. Hallyn wrote:
> Quoting Arjan van de Ven (arjan@infradead.org):
>>> A one time effort to write it *and sign it*.
>> you don't sign nor need to sign perl or bash scripts. Why would a loader
>> be written in ELF itself? There's absolutely no reason for that.
> 
> Yup, that's an unfortunate shortcoming.  We'd been wanting to re-post to
> lkml for a long time to get ideas to fix that.
> 
> I had an extension to digsig earlier which enabled signing shellscripts
> using xattrs (just because it was a trivial task), but that's clearly
> insufficient as it would catch "./myscript.pl" but not "perl
> myscript.pl".

Another thing to do is to modify perl to verify signatures of
the scripts it's executing, sign *that* perl binary, and disallow
executing of unsigned perl scripts...

/mjt, who's joking only partially.
