Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWCZNsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWCZNsN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 08:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWCZNsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 08:48:13 -0500
Received: from smtpout.mac.com ([17.250.248.44]:52438 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751183AbWCZNsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 08:48:13 -0500
In-Reply-To: <4426974D.8040309@argo.co.il>
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl> <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com> <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060326065205.d691539c.mrmacman_g4@mac.com> <1143376008.3064.0.camel@laptopd505.fenrus.org> <F31089B5-0915-439D-B218-009384E2148F@mac.com> <4426974D.8040309@argo.co.il>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <25A7D808-9900-4035-BEB3-A782C5EF8EF4@mac.com>
Cc: Arjan van de Ven <arjan@infradead.org>, nix@esperi.org.uk, rob@landley.net,
       mmazur@kernel.pl, linux-kernel@vger.kernel.org,
       llh-discuss@lists.pld-linux.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
Date: Sun, 26 Mar 2006 08:47:51 -0500
To: Avi Kivity <avi@argo.co.il>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 26, 2006, at 08:29:49, Avi Kivity wrote:
> Kyle Moffett wrote:
>> Well I guess you could call it UABI, but that might also imply  
>> that it's _userspace_ that defines the interface, instead of the  
>> kernel.  Since the headers themselves are rather tightly coupled  
>> with the kernel, I think I'll stick with the KABI name for now  
>> (unless somebody can come up with a better one, of course :-D).
>
> How about __linux, or __linux_abi? There are ABIs for other  
> components, and other OSes. Linux is the name of the project after  
> all.

The other thing that I quickly noticed while writing up the patches  
is that it's kind of tedious typing __kabi_ over and over again.  I  
actually did first try with __linux_abi_ but the typing effort and  
finger cramps made me give up on that really quickly.

Cheers,
Kyle Moffett

