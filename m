Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264266AbUESP5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbUESP5W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 11:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbUESP5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 11:57:21 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:2566 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264274AbUESP4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 11:56:43 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Organization: Linux-Systeme GmbH
To: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c:98 -- compiling with distcc
Date: Wed, 19 May 2004 17:50:10 +0200
User-Agent: KMail/1.6.2
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Carson Gaspar <carson@taltos.org>, Marco Fais <marco.fais@abbeynet.it>
References: <406D3E8F.20902@abbeynet.it> <20040505183558.GB1350@logos.cnet> <20040519115950.GE12419@logos.cnet>
In-Reply-To: <20040519115950.GE12419@logos.cnet>
X-Operating-System: Linux 2.6.5-wolk3.0 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200405191750.10090@WOLK>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 May 2004 13:59, Marcelo Tosatti wrote:

Hi Marcelo, Carson ...

> > > >>[1.] Kernel panic while using distcc
> > > >>[2.] I have 5-6 development linux systems that we use without problem
> > > >>under a normal development workload. Trying distcc for speeding up
> > > >>compilation, we have a fully reproducible kernel panic in a very
> > > >> short time (seconds after compilation start). The kernel panic
> > > >> happens *only* when the systems are "remotely controlled" (the
> > > >> distcc daemon is receiving source files from remote systems, compile
> > > >> and send back compiled objects). When compiling with distcc the
> > > >> local system doesn't show any kernel panic, while the same system
> > > >> used as a "remote compiler system" dies very quickly.
> > > >>[3.] Keywords: distcc BUG page_alloc.c

> So did Andrea's fix work for you? :)

sorry if I did not follow this thread from the beginning, but why is distcc 
causing a BUG() in page_alloc.c? I use distcc since I don't know when and 
never had any BUG() in page_alloc with distcc, nor the specific bug at :98.

I have 7 machines in my distcc farm, and all are "remote controlled".

Could someone please clarify me? Thank you.

ciao, Marc

