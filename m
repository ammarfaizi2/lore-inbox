Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992822AbWJUDaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992822AbWJUDaz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 23:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992830AbWJUDaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 23:30:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28567 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S2992822AbWJUDay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 23:30:54 -0400
Date: Fri, 20 Oct 2006 23:30:49 -0400
From: Dave Jones <davej@redhat.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Steven Truong <midair77@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Machine Check Exception on dual core Xeon
Message-ID: <20061021033049.GC17706@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Kyle Moffett <mrmacman_g4@mac.com>,
	Steven Truong <midair77@gmail.com>, linux-kernel@vger.kernel.org
References: <28bb77d30610171634l5db9d909v2c4cd12972e9d5@mail.gmail.com> <90DB029B-222B-4D0C-8642-913CD81D5C9B@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90DB029B-222B-4D0C-8642-913CD81D5C9B@mac.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 09:43:20PM -0400, Kyle Moffett wrote:
 > On Oct 17, 2006, at 19:34:59, Steven Truong wrote:
 > > Hi, all.  I have this node of dual core Xeon 3.2 GHz, 4 Gig of RAM and
 > > kernel 2.16.18 on CentOS 4.3.  I got kernel panic and after setting up
 > > kdump/kexec I was able to capture the kdump core.
 > > I found out this message with crash to analyze the core dump:
 > >
 > > HARDWARE ERROR
 > > CPU 0: Machine Check Exception:                4 Bank 3:  
 > > 0000000000000000
 > > TSC 0
 > > This is not a software problem!
 > > Run through mcelog --ascii to decode and contact your hardware vendor
 > 
 > You missed the blatantly obvious error message:
 > "This is not a software problem!"
 > 
 > Immediately followed by:
 > "contact your hardware vendor"
 > 
 > Please follow that advice

Maybe someone needs to implement <blink> tags for printk ;-)

	Dave

-- 
http://www.codemonkey.org.uk
