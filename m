Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbTDIXSD (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 19:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263849AbTDIXSC (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 19:18:02 -0400
Received: from aneto.able.es ([212.97.163.22]:54931 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S263626AbTDIXR7 (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 19:17:59 -0400
Date: Thu, 10 Apr 2003 01:29:31 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Daniel Jacobowitz <dan@debian.org>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] detached cloning
Message-ID: <20030409232931.GA15917@werewolf.able.es>
References: <Pine.LNX.4.53L.0304041815110.32674@freak.distro.conectiva> <20030405224233.GA12746@werewolf.able.es> <20030405230944.GG12864@werewolf.able.es> <20030407231321.GA14633@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030407231321.GA14633@nevyn.them.org>; from dan@debian.org on Tue, Apr 08, 2003 at 01:13:21 +0200
X-Mailer: Balsa 2.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.08, Daniel Jacobowitz wrote:
> On Sun, Apr 06, 2003 at 01:09:44AM +0200, J.A. Magallon wrote:
> > 
> > On 04.06, J.A. Magallon wrote:
> > > 
> > > On 04.04, Marcelo Tosatti wrote:
> > > > 
> > > > So here goes -pre7. Hopefully the last -pre.
> > > > 
> > > 
> > 
> > Fix a crash that can be caused by a CLONE_DETACHED thread.
> > Author: Ingo Molnar <mingo@elte.hu>
> > 
[...]
> 
> CLONE_DETACHED isn't even in 2.4 except in Red Hat kernels.
> 

But pthreads can spawn detached threads. Can this have any effect ?

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-pre7-jam1 (gcc 3.2.2 (Mandrake Linux 9.2 3.2.2-5mdk))
