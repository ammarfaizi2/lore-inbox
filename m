Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945991AbWKJG5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945991AbWKJG5f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 01:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946002AbWKJG5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 01:57:35 -0500
Received: from ns1.suse.de ([195.135.220.2]:35787 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1945998AbWKJG5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 01:57:34 -0500
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] sysctl:  Undeprecate sys_sysctl (take 2)
Date: Fri, 10 Nov 2006 07:50:10 +0100
User-Agent: KMail/1.9.5
Cc: "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Jesper Juhl" <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       alan@redhat.com, "Russell King" <rmk+lkml@arm.linux.org.uk>,
       "Jakub Jelinek" <jakub@redhat.com>, "Mike Galbraith" <efault@gmx.de>,
       "Albert Cahalan" <acahalan@gmail.com>,
       "Bill Nottingham" <notting@redhat.com>,
       "Marco Roeland" <marco.roeland@xs4all.nl>,
       "Michael Kerrisk" <mtk-manpages@gmx.net>
References: <m1zmb13gsl.fsf@ebiederm.dsl.xmission.com> <9a8748490611081110m4cc62c1bp3a36aba3fc314e56@mail.gmail.com> <m1ejsd3e38.fsf_-_@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ejsd3e38.fsf_-_@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611100750.10990.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 November 2006 20:58, Eric W. Biederman wrote:
> 
> The basic issue is that despite have been ``deprecated'' and
> warned about as a very bad thing in the man pages since it's
> inception there are a few real users of sys_sysctl. 

But they only seem to use a small number of actually used with
sysctl(2) sysctls.
I still think just maintaining a conversion table for 
those is the right thing to do.

The important part really is to get rid of the crufty 
old infrastructure internally.

-Andi

