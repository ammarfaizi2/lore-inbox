Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbUAVW5f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 17:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266441AbUAVW5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 17:57:34 -0500
Received: from nevyn.them.org ([66.93.172.17]:33188 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S265125AbUAVW5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 17:57:32 -0500
Date: Thu, 22 Jan 2004 17:57:31 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: KGDB 2.0.3 with fixes and development in ethernet interface
Message-ID: <20040122225731.GA19220@nevyn.them.org>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <200401161759.59098.amitkale@emsyssoft.com> <200401211916.49520.amitkale@emsyssoft.com> <400F0490.6000209@mvista.com> <200401221039.14979.amitkale@emsyssoft.com> <20040122172035.GI15271@stop.crashing.org> <401054BF.2080701@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401054BF.2080701@mvista.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 02:54:55PM -0800, George Anzinger wrote:
> Daniel has suggested that we could just use the new bin tools where in the 
> gas program will build the call frames.  I am not sure it can handle 
> expressions, however.  And they are needed if you want to tie off the frame 
> if the next step is user land.

Well, we could add a dwarf expression parser to gas quite easily if
desired.

> By the way, I don't try to build a blow by blow of the frame.  Rather I 
> assume it is only of interest at those points where calls are made out of 
> the interrupt /trap code.  (Or, in some cases, jumps are made back into it.)

Only matters if you can be in KGDB at a particular instruction.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
