Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVGLJrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVGLJrt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 05:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVGLJpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 05:45:43 -0400
Received: from nproxy.gmail.com ([64.233.182.194]:45164 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261301AbVGLJn0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 05:43:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RCABcDUlCXEc6gdW8CkyhuFt5iz2FKwPMbHPh37q2lNX38QiuvkKzEPDSzENgxov8Qx3dmi7V1+3E+kY8Gzg53G8ugqUebpgWK5m5ktkYkXsN4d9zN3zuueCXO4D+r/j6DfUonOqVbPoJ/7oXme/3CXA57in7yOM/cTzTdQCX5o=
Message-ID: <4ad99e05050712024319bc7ada@mail.gmail.com>
Date: Tue, 12 Jul 2005 11:43:23 +0200
From: Lars Roland <lroland@gmail.com>
Reply-To: Lars Roland <lroland@gmail.com>
To: Rob Mueller <robm@fastmail.fm>
Subject: Re: 2.6.12.2 dies after 24 hours
Cc: linux-kernel@vger.kernel.org, Bron Gondwana <brong@fastmail.fm>,
       Jeremy Howard <jhoward@fastmail.fm>
In-Reply-To: <01dd01c586c3$cdd525d0$7c00a8c0@ROBMHP>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <01dd01c586c3$cdd525d0$7c00a8c0@ROBMHP>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/05, Rob Mueller <robm@fastmail.fm> wrote:
> As background, we've been using a relatively old kernel (2.6.4-mm2) on some
> IBM x235 machines with 6G of RAM, umem cards, and serveraid storage. These
> machines are under continuous heavy-ish load, load avg between about 1 and
> 5, with between 2500-3500 procs at all times, with several largish ReiserFS
> partitions and have been running *really* well with >250 days uptime on one
> machine.
> 
> We recently tried upgrading one of the machines to the latest kernel
> (2.6.12.2) and it's died after about 24 hours. It seemed to end up in some
> weird state where we could ssh into it, and some commands worked (eg uptime)
> but process list related commands (ps) would just freeze up into an
> unkillable state and we'd have to close the seesion and ssh in again.

I experienced the exact same thing on a IBM 335 - in my case I had
messed up with the ACPI setup. Could you paste the output from
/proc/interupts also is your kernel running with IRQ balancing ?.


Regards.

Lars Roland
