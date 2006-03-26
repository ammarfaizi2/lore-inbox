Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWCZOsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWCZOsS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 09:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWCZOsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 09:48:18 -0500
Received: from main.gmane.org ([80.91.229.2]:10912 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751203AbWCZOsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 09:48:18 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
Date: Sun, 26 Mar 2006 16:45:41 +0200
Message-ID: <11mpdnntc48oi.sq072ivuow2z.dlg@40tude.net>
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl> <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com> <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060326065205.d691539c.mrmacman_g4@mac.com> <1143376008.3064.0.camel@laptopd505.fenrus.org> <F31089B5-0915-439D-B218-009384E2148F@mac.com> <4426974D.8040309@argo.co.il> <25A7D808-9900-4035-BEB3-A782C5EF8EF4@mac.com> <1j559cjhfl0bj.1cvtvnq8t1x0t.dlg@40tude.net> <9A9D2580-8BA4-4A40-AB92-C34C60CE5E58@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-84-221-14-16.cust-adsl.tiscali.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Mar 2006 09:30:32 -0500, Kyle Moffett wrote:

> On Mar 26, 2006, at 08:53:05, Giuseppe Bilotta wrote:
>> On Sun, 26 Mar 2006 08:47:51 -0500, Kyle Moffett wrote:
>>> The other thing that I quickly noticed while writing up the  
>>> patches is that it's kind of tedious typing __kabi_ over and over  
>>> again.  I actually did first try with __linux_abi_ but the typing  
>>> effort and finger cramps made me give up on that really quickly.
>>
>> What kind of barebone editor are you using that doesn't offer a way  
>> (through macro or automatic completion or abbreviations or  
>> substitution or plain copy and paste or whatever else) to shorten  
>> that typing effort?
> 
> Well, actually I was using vim, and although I know how to configure  
> shortcuts like that; do we really want to force people to use  
> shortcuts and abbreviations to be able to sanely edit the ABI code?   
> Isn't that counterproductive with the desire to get the maintainers  
> fixing up their own ABIs?  Plus all the extra verbiage tends to make  
> the lines too long (80-column limit) and makes it harder to read.

Oh, I'm not exactly a fan of verbosity myself (essentially for the
lines too long and hard to read), which is why I suggested __labi_ as
a prefix --I wasn't arguing in favour of __linux_abi_.

However, as far as I know all programmer-friendly editors have some
form of easy to use code-completion feature (e.g. in vim ctrl+n/ctrl+p
are very handy without the need to define specific shortcuts, and the
new completion code in the future vim 7 is extremely promising ...)
and while I do agree that __linux_abi_ is too long, you remarked
yourself __[ukl]abi_ is still annoying, albeit shorter :) *Any* prefix
chosen will benefit from completion ;)

-- 
Giuseppe "Oblomov" Bilotta

"They that can give up essential liberty to obtain
a little temporary safety deserve neither liberty
nor safety." Benjamin Franklin

