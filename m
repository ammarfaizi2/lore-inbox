Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264222AbUD0Rxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264222AbUD0Rxt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 13:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264243AbUD0Rxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 13:53:49 -0400
Received: from [80.72.36.106] ([80.72.36.106]:35207 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S264222AbUD0Rxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 13:53:47 -0400
Date: Tue, 27 Apr 2004 19:53:39 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Marc Boucher <marc@linuxant.com>, Adam Jaskiewicz <ajjaskie@mtu.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <408E9C59.2090502@nortelnetworks.com>
Message-ID: <Pine.LNX.4.58.0404271950170.4424@alpha.polcom.net>
References: <20040427165819.GA23961@valve.mbsi.ca> <408E9771.7020302@mtu.edu>
 <F55B44BB-9870-11D8-85DF-000A95BCAC26@linuxant.com> <408E9C59.2090502@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004, Chris Friesen wrote:

> Marc Boucher wrote:
> 
> > On Apr 27, 2004, at 1:25 PM, Adam Jaskiewicz wrote:
> 
> >> Would it not be better to simply place a notice in the readme 
> >> explaining what
> >> the error messages mean, rather than working around the liscense checking
> >> code? Educate the users, rather than fibbing.
> > 
> > 
> > Good idea. We will try to clarify the matter in the docs for the next 
> > release.
> > A lot of users don't read them though, so a proper fix remains necessary..
> 
> Does your company honestly feel that misleading the module loading tools is actually the proper way 
> to work around the issue of repetitive warning messages?  This is blatently misleading and does not 
> reflect well, especially when the "GPL" directory mentioned in the source string is actually empty.
> 
> A "proper fix" begins with not attempting to mislead the kernel/tools about the license...

Maybe kernel should display warning only once per given licence or even 
once per boot (who needs warning about tainting tainted kernel?)


Grzegorz Kulewski

