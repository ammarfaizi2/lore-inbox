Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWEYDnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWEYDnl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 23:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWEYDnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 23:43:41 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:41600 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S964865AbWEYDnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 23:43:40 -0400
Subject: Re: [Fastboot] [PATCH 01/03] kexec: Avoid overwriting the current
	pgd (V2, stubs)
From: Magnus Damm <magnus@valinux.co.jp>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <m1wtcasu5b.fsf@ebiederm.dsl.xmission.com>
References: <20060524044232.14219.68240.sendpatchset@cherry.local>
	 <20060524044237.14219.15615.sendpatchset@cherry.local>
	 <m1wtcasu5b.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Thu, 25 May 2006 12:45:42 +0900
Message-Id: <1148528742.5793.135.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 20:41 -0600, Eric W. Biederman wrote:
> Magnus Damm <magnus@valinux.co.jp> writes:
> 
> > --===============059810052910035161==
> >
> > kexec: Avoid overwriting the current pgd (V2, stubs)
> >
> > This patch adds an architecture specific structure "struct kimage_arch" to 
> > struct kimage. This structure is filled in with members by the architecture
> > specific patches followed by this one.
> 
> You should be able to completely remove the need for this by simply
> adding a single additional external variable to the control code
> page.  Given that you abuse this information and store way more
> than you need I am not persuaded that it is an interesting case.

I'm sorry, but I do not understand. Care to explain a bit more, maybe
with some examples?

Also, I get the impression that you dislike my patches. I'd like to work
with you and the community to merge my patches, but for that to happen
I'd appreciate if we both kept the language on a professional level.

Next time, please try to avoid strong words such as "abuse", "horrible"
and "ridiculous".

Thanks,

/ magnus

