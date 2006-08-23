Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbWHWVCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbWHWVCy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 17:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbWHWVCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 17:02:54 -0400
Received: from gw.goop.org ([64.81.55.164]:14721 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S965025AbWHWVCy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 17:02:54 -0400
Message-ID: <44ECC27C.2020401@goop.org>
Date: Wed, 23 Aug 2006 14:02:52 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Ian Campbell <Ian.Campbell@XenSource.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       Virtualization <virtualization@lists.osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Translate asm version of ELFNOTE macro	into	preprocessor
 macro
References: <1156333761.12949.35.camel@localhost.localdomain>	 <44EC6B12.4060909@goop.org>	 <1156346074.12949.129.camel@localhost.localdomain>	 <44EC72F3.70505@goop.org> <m1sljnml73.fsf@ebiederm.dsl.xmission.com>	 <44EC94C2.9080608@goop.org> <1156362207.19808.69.camel@localhost.localdomain>
In-Reply-To: <1156362207.19808.69.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Campbell wrote:
> Surprisingly string concatenation doesn't appear to be required for the
> majority of punctuation, at least so far as I can tell with this test
> patch (this is a xen-unstable kernel I had lying around so don't pay too
> much attention to head-xen.S bit). The only problem I found is comma,
> which can't be escaped.
>
> I've no idea how reliably this works across tool chain versions etc
> though. It worked for me ;-)
>   

I guess that's a broad enough selection of names.  I had assumed it 
would impose normal symbol-like restrictions on the unquoted section 
name.  (I guess ';' would also need quoting.)

    J
