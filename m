Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264750AbUFPUlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264750AbUFPUlT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 16:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264756AbUFPUlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 16:41:19 -0400
Received: from edu.joroinen.fi ([194.89.68.130]:55763 "EHLO edu.joroinen.fi")
	by vger.kernel.org with ESMTP id S264750AbUFPUlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 16:41:18 -0400
Date: Wed, 16 Jun 2004 23:41:17 +0300
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To: Brian Gao <bgaolinux@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 32 group limitation
Message-ID: <20040616204117.GB11282@edu.joroinen.fi>
References: <20040616202050.37641.qmail@web60906.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040616202050.37641.qmail@web60906.mail.yahoo.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 01:20:50PM -0700, Brian Gao wrote:
> Hi,
> 
> We are runing Redhat Enterprise Linux AS 2.1 ( kernel
> 2.4.9-e.40) on a 
> Dell 2650 box. There is a need in our application for
> a user to belong 
> to more than 32 groups. Is there a way to recompile
> the kernel to 
> support more than 32 supplementary groups ? 
>  
> I'm not a subscriber of the mailing list. Please CC me
> your 
> answers/comments posted to the list. Any help would be
> greatly appreciated.
>  

New Linux 2.6 kernels support >32 groups per user. The libc also needs to be
recompiled for >32 support.

So I guess you're out of luck with RHEL AS 2.1. I'm not sure about RHEL 3
support either..

-- Pasi Kärkkäinen
       
                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.
