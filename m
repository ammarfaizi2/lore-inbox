Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbWCUWsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWCUWsi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 17:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWCUWsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 17:48:38 -0500
Received: from host245-95.pool217223.interbusiness.it ([217.223.95.245]:64429
	"EHLO rc-vaio.rcdiostrouska.com") by vger.kernel.org with ESMTP
	id S964874AbWCUWsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 17:48:37 -0500
Subject: Re: p4-clockmod not working in 2.6.16
From: Sasa Ostrouska <sasa.ostrouska@volja.net>
Reply-To: sasa.ostrouska@volja.net
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060321222016.GB8583@redhat.com>
References: <1142974528.3470.4.camel@localhost>
	 <20060321210106.GA25370@redhat.com> <1142978230.3470.12.camel@localhost>
	 <20060321220115.GA8583@redhat.com> <1142979226.3470.18.camel@localhost>
	 <20060321222016.GB8583@redhat.com>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 23:51:41 +0100
Message-Id: <1142981501.7153.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 Dropline GNOME 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 17:20 -0500, Dave Jones wrote:
> On Tue, Mar 21, 2006 at 11:13:45PM +0100, Sasa Ostrouska wrote:
> 
>  > Patch failed :(
>  > 
>  > root@rc-vaio:/usr/src/linux-2.6.16# patch -p1 < ../linux-2.6.16-p4-clockmod.diff
>  > patching file arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
>  > Hunk #1 FAILED at 244.
>  > 1 out of 1 hunk FAILED -- saving rejects to file arch/i386/kernel/cpu/cpufreq/p4-clockmod.c.rej
>  > root@rc-vaio:/usr/src/linux-2.6.16#
> 
> Something isn't right with your tree. Are you sure that's a 2.6.16 ?
> 
> (17:19:17:davej@linux-2.6.16)$ patch -p1 --dry-run < ~/cf
> patching file arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
> (17:19:24:davej@linux-2.6.16)$
> 
> 		Dave
> 

Sure if the incremental patches are right then this is it. In any case
the patch has not applied but changing that line as per your patch, I
got it working. Now, it loads and it seems that it works. 
I looked at my CPU frequency scaling applet in GNOME and it shows 
only frequencies from 2,8GHz to 2,1GHz. I dont remember it well but if 
I'm not wrong earlier it was showing frequencies until 600MHz. Is this 
possible ?

Thanks & Rgds
Sasa

