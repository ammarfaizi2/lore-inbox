Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262269AbUKQKtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbUKQKtm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 05:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbUKQKtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 05:49:41 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:16617 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262269AbUKQKse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 05:48:34 -0500
Subject: Re: Slab corruption with 2.6.9 + swsusp2.1
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Ake <Ake.Sandgren@hpc2n.umu.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041117064403.GB26723@hpc2n.umu.se>
References: <20041116115917.GN4344@hpc2n.umu.se>
	 <1100635759.4362.4.camel@desktop.cunninghams>
	 <20041117064403.GB26723@hpc2n.umu.se>
Content-Type: text/plain
Message-Id: <1100688279.4040.4.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 17 Nov 2004 21:44:40 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-11-17 at 17:44, Ake wrote:
> On Wed, Nov 17, 2004 at 07:09:19AM +1100, Nigel Cunningham wrote:
> > On Tue, 2004-11-16 at 22:59, Ake wrote:
> > > I got a slab corruption message running 2.6.9 + swsusp2.1 and
> > > nvidia_compat.patch + vm-pages_scanned-active_list.patch from -ck3.
> > 
> > Just so I'm clear, why do you think it's suspending that's causing the
> > corruption?
> 
> I don't. I was just making clear exactly what kernel source i was using.

Oh, okay. I was going off the subject :>

Had you suspended prior to this? If not, you can rule the suspend code
out. If you had, I wouldn't rule it out because I am trying to identify
the cause of some occasional slab corruption at the moment. Haven't got
it reproducible yet.

> It probably haven't got anything to do with the swsusp code, but since
> those patches are applied i though i better let you know.
> 
> The machine was basically doing nothing since i was out for lunch.
> X was running screensaver and it was playing some mp3's.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

