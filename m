Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbVFUUfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbVFUUfL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 16:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbVFUUeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:34:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47514 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262247AbVFUUdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:33:10 -0400
Date: Tue, 21 Jun 2005 13:32:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
Message-Id: <20050621133236.7c98d5d8.akpm@osdl.org>
In-Reply-To: <1119369028.19357.28.camel@mindpipe>
References: <20050620235458.5b437274.akpm@osdl.org>
	<1119369028.19357.28.camel@mindpipe>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> On Mon, 2005-06-20 at 23:54 -0700, Andrew Morton wrote:
> > CONFIG_HZ for x86 and ia64: changes default HZ to 250, make HZ
> > Kconfigurable.
> > 
> >     Will merge (will switch default to 1000 Hz later if that seems
> > necessary) 
> 
> Are you serious?  You're changing the *default* HZ in a stable kernel
> series?!?
> 
> This is a big regression, it degrades the resolution of system calls.
> 

Well we'll see what happens.  As I said, if it's determined to be a real
problem we'll put the default back to 1000Hz prior to 2.6.13 release.
