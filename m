Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290605AbSBKXvk>; Mon, 11 Feb 2002 18:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290598AbSBKXva>; Mon, 11 Feb 2002 18:51:30 -0500
Received: from are.twiddle.net ([64.81.246.98]:8581 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S290596AbSBKXvM>;
	Mon, 11 Feb 2002 18:51:12 -0500
Date: Mon, 11 Feb 2002 15:49:17 -0800
From: Richard Henderson <rth@twiddle.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Robert Love <rml@tech9.net>, Luigi Genoni <kernel@Expansa.sns.it>,
        Arkadiy Chapkis - Arc <achapkis@mail.dls.net>,
        LINUX-KERNEL@vger.kernel.org
Subject: Re: thread_info implementation
Message-ID: <20020211154917.A19367@are.twiddle.net>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	Robert Love <rml@tech9.net>, Luigi Genoni <kernel@Expansa.sns.it>,
	Arkadiy Chapkis - Arc <achapkis@mail.dls.net>,
	LINUX-KERNEL@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0202112140280.6590-100000@Expansa.sns.it> <1013460534.6784.477.camel@phantasy> <3C6855A2.4721DDD3@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C6855A2.4721DDD3@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Feb 11, 2002 at 06:37:06PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2002 at 06:37:06PM -0500, Jeff Garzik wrote:
> ... Richard Henderon got alpha axp going with thread_info,
> though only in UP so far.

The SMP patch had one stupid missing line.  So that's working now too.

Though I seem to be having some problems with NFS.  Mount goes into D
state for quite some time and the portmapper complains about timeouts
connecting to localhost.  Anyone else see anything like that?  I suppose
I'll build an x86 kernel from the same source and see what I can find...


r~
