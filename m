Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbTH0VDa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 17:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262304AbTH0VDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 17:03:30 -0400
Received: from www.13thfloor.at ([212.16.59.250]:21463 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S262290AbTH0VD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 17:03:28 -0400
Date: Wed, 27 Aug 2003 23:03:42 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.23-pre1] /proc/ikconfig support
Message-ID: <20030827210341.GE26817@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0308261629400.18109@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0308261629400.18109@freak.distro.conectiva>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 04:33:09PM -0300, Marcelo Tosatti wrote:
> 
> On Tue, 26 Aug 2003 18:36:59 +0200 Marc-Christian Petersen
> <m.c.p@wolk-project.de> wrote:
> 
> | On Monday 25 August 2003 19:50, Marc-Christian Petersen wrote:
> |
> | Hi Marcelo,
> |
> | > Idea/Patch from Randy Dunlap including fixes/updates:
> | > From: Daniele Bellucci <bellucda@tiscali.it>
> | >     put_user() to return -EFAULT on error.
> | > From: Randy.Dunlap" <rddunlap@osdl.org>
> | >     Updated 'extract-ikconfig' script
> | > From me:
> | >     /proc/ikconfig should only be allowed if CONFIG_PROC_FS=y
> | > Attached is /proc/ikconfig support.
> ...
> |
> | something not ok with this or do you just need some time to review it?
> :)
> 
> > I have the same question about the seq_file "single" additions
> > patch that I sent yesterday.... ???
> 
> The seq_file patch needs EXPORT_SYMBOL right?
> 
> And about ikconfig, hum, I'm not sure if I want that. Its nice, yes, but I
> still wonder. You are free to convince me though: I think people usually
> know what they compile in their kernels, dont they?

not if you do 20 kernels a week, and then want to know
the config for machine XY, to compile a new kernel ...

since early 2.4.18 I'm happy with kconfig[1] but I guess
ikconfig will do almost the same ...

best,
Herbert

[1] http://www.13thfloor.at/VServer/patches-2.4.22-p10c17/03_kconfig-2.4.22-pre3.patch.bz2

