Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWFBULa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWFBULa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 16:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWFBULa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 16:11:30 -0400
Received: from aa006msg.fastwebnet.it ([213.140.2.73]:40106 "EHLO
	aa006msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932173AbWFBUL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 16:11:29 -0400
Date: Fri, 2 Jun 2006 22:09:25 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm2
Message-ID: <20060602220925.69c6a76f@localhost>
In-Reply-To: <20060602194947.GA1214@elte.hu>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	<20060602120952.615cea39@localhost>
	<20060602111053.GA22306@elte.hu>
	<20060602111704.GA22841@elte.hu>
	<20060602133403.4eed2de7@localhost>
	<20060602141349.GA8974@elte.hu>
	<20060602164624.22ba617e@localhost>
	<20060602194947.GA1214@elte.hu>
X-Mailer: Sylpheed-Claws 2.3.0-rc3 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2006 21:49:47 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> ok, this was yet another slab.c early init assumption ...
> 
> could try the latest combo patch at:
> 
>   http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-rc5-mm2.patch
> 
> does this one finally boot for you?

I've applied the single patch. At first I've got problems (lots of
messages scrolling on the screen, and then a kernel panic). They are
related to netconsole because disabling it lets me boot :)

If the problem with netconsole doesn't go away I'll set up a serial
console to capture the enormous output.

-- 
	Paolo Ornati
>>>	Linux 2.6.17-rc5-mm2-lockdep on x86_64 <<<
