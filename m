Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264090AbTEGP4i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264092AbTEGP4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:56:35 -0400
Received: from s-smtp-osl-01.bluecom.no ([62.101.193.35]:61853 "EHLO
	s-smtp-osl-01.bluecom.no") by vger.kernel.org with ESMTP
	id S264090AbTEGPz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:55:58 -0400
Subject: Re: The disappearing sys_call_table export.
From: petter wahlman <petter@bluezone.no>
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0305071147510.12652@chaos>
References: <1052321673.3727.737.camel@badeip>
	 <Pine.LNX.4.53.0305071147510.12652@chaos>
Content-Type: text/plain
Organization: 
Message-Id: <1052323711.3739.750.camel@badeip>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 07 May 2003 18:08:31 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-07 at 18:00, Richard B. Johnson wrote:
> On Wed, 7 May 2003, petter wahlman wrote:
> 
> >
> > It seems like nobody belives that there are any technically valid
> > reasons for hooking system calls, but how should e.g anti virus
> > on-access scanners intercept syscalls?
> > Preloading libraries, ptracing init, patching g/libc, etc. are
>   ^^^^^^^^^^^^^^^^^^^
>                     |________  Is the way to go. That's how
> you communicate every system-call to a user-mode daemon that
> does whatever you want it to do, including phoning the National
> Security Administrator if that's the policy.
> 
> > obviously not the way to go.
> >
> 
> Oviously wrong.


And how would you force the virus to preload this library?

-p.


