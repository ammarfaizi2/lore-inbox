Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbVBQUKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbVBQUKQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 15:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbVBQUKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 15:10:15 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:24081 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262337AbVBQUJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 15:09:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=oK2+jqWsqmd1tQNI7fVFHTNXITIL0v1rGUZ5qn/I+EmrGBLOCEOmcjt4eBBjJaz6AiKjvumnlMg8qNWzsIBRy6JzhiPjyFIFSaVLPvunX+HOXiQW4/KRd3VA1dQ1nEa0maFKua5lLiwQea1R8hl8sSJNE7yy1Weo78w9+OpnhkU=
Message-ID: <d120d50005021712092241f9ec@mail.gmail.com>
Date: Thu, 17 Feb 2005 15:09:51 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Swsusp, resume and kernel versions
Cc: John M Flinchbaugh <john@hjsoft.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050217195651.GB5963@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200502162346.26143.dtor_core@ameritech.net>
	 <20050217110731.GE1353@elf.ucw.cz>
	 <20050217162847.GA32488@butterfly.hjsoft.com>
	 <d120d5000502170930ccc3e9e@mail.gmail.com>
	 <20050217195651.GB5963@openzaurus.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2005 20:56:52 +0100, Pavel Machek <pavel@suse.cz> wrote:
> Hi!
> 
> > > Just remember you're doing the mkswap if you decide to rearrange your
> > > partitions at all, or code a script smart enough to grep your swap
> > > partitions out of your fstab.
> >
> > It could be a workaround. Still it will cause loss of unsaved work if
> > I happen to load wrong kernel. Given that the code checking for swsusp
> > image can be marked __init I don't understand the reasons gainst doing
> > it.
> 
> How do you know which partitions to check? swsusp gets it from resume= parameter,
> but if you do not have it compiled, you probably have wrong cmdline, too.
>

Ok, that makes sense. I guess I should just stop pulling vendor
kernels with the rest of updates since I am not using them anyway.

Sorry for the noise.

-- 
Dmitry
