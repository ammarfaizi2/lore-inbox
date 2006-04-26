Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWDZEnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWDZEnw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 00:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbWDZEnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 00:43:51 -0400
Received: from smtpout.mac.com ([17.250.248.186]:16367 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932360AbWDZEnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 00:43:50 -0400
In-Reply-To: <200604251952.k3PJqj2J010248@turing-police.cc.vt.edu>
References: <20060425161139.87285.qmail@web26109.mail.ukl.yahoo.com> <1145984201.3114.34.camel@laptopd505.fenrus.org> <878xpto53w.fsf@hades.wkstn.nix> <1145993869.3114.38.camel@laptopd505.fenrus.org> <200604251952.k3PJqj2J010248@turing-police.cc.vt.edu>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E4450568-890D-4BD1-85AF-95BCB7F4978B@mac.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Nix <nix@esperi.org.uk>,
       Axelle Apvrille <axelle_apvrille@yahoo.fr>, drepper@gmail.com,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       disec-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for run-timeauthentication of binaries
Date: Wed, 26 Apr 2006 00:43:07 -0400
To: Valdis.Kletnieks@vt.edu
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 25, 2006, at 15:52:45, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 25 Apr 2006 21:37:48 +0200, Arjan van de Ven said:
>> On Tue, 2006-04-25 at 19:57 +0100, Nix wrote:
>>> On Tue, 25 Apr 2006, Arjan van de Ven said:
>>>> so you didn't sign perl ? or bash ?
>>>
>>> You can write an elf loader in bash?!
>>
>> I've not tried it.. but afaics bash scripts are sufficiently  
>> turing complete to pull it off ;)
>
> Well, somebody did 'shasm' (an assembler in bash), so I don't see  
> any reason you can't do an elf loader... (OK, so you *might* have  
> to write a machine emulator in bash, store the binary in an array,  
> and emulate the sucker...)

Well I know that there are ways in Perl to overwrite arbitrary memory  
(it's considered a bug of a certain XS library, although it has no  
security implications because you could do the equivalent in Perl  
anyways).  I would assume that it's quite possible to do the same in  
bash with a specially formatted bash script.  Once you can scribble  
on arbitrary memory, you can load a compiled ELF loader and execute  
it without much trouble at all.  A signed perl binary would open a  
hole the size of a barn door in your scheme, I think.

Cheers,
Kyle Moffett

