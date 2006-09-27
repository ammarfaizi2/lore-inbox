Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031215AbWI0XGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031215AbWI0XGx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 19:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031216AbWI0XGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 19:06:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33210 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1031212AbWI0XGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 19:06:51 -0400
Date: Wed, 27 Sep 2006 16:06:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Aaron Durbin" <adurbin@google.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, "Andi Kleen" <ak@suse.de>,
       linux-kernel@vger.kernel.org, nil@google.com
Subject: Re: 2.6.18-mm1
Message-Id: <20060927160643.2afb9ff4.akpm@osdl.org>
In-Reply-To: <8f95bb250609271506x526a7ac5j99c110dce0f662e0@mail.google.com>
References: <20060924040215.8e6e7f1a.akpm@osdl.org>
	<200609270913.15688.ak@suse.de>
	<m14putpxks.fsf@ebiederm.dsl.xmission.com>
	<200609270951.17124.ak@suse.de>
	<m1hcyto112.fsf@ebiederm.dsl.xmission.com>
	<8f95bb250609271506x526a7ac5j99c110dce0f662e0@mail.google.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 15:06:14 -0700
"Aaron Durbin" <adurbin@google.com> wrote:

> 
> I agree that clearing the IORESOURCE_BUSY flag would not alleviate
> this problem.  Could you please post the output of 'lspci -vvvvx' so
> we could better understand the layout of your box?  Perhaps I might
> have to defer the registration of the resources until later.  It seems
> weird that the IO APIC are mapped in as PCI devices though.

I think we should aim to get some extra debugging into this code, to help
us diagnose things like http://bugzilla.kernel.org/show_bug.cgi?id=7218

We get quite a few reports of this nature, and the kernel does seem to have
regressed.


