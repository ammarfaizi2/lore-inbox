Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVEZH7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVEZH7p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 03:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVEZH7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 03:59:45 -0400
Received: from fire.osdl.org ([65.172.181.4]:38068 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261264AbVEZH7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 03:59:38 -0400
Date: Thu, 26 May 2005 00:58:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: tomlins@cam.org, linux-kernel@vger.kernel.org,
       alsa-devel@lists.sourceforge.net
Subject: Re: 2.6.12-rc5-mm1
Message-Id: <20050526005841.08a8aae0.akpm@osdl.org>
In-Reply-To: <1117093392l.17165l.0l@werewolf.able.es>
References: <20050525134933.5c22234a.akpm@osdl.org>
	<200505252243.21092.tomlins@cam.org>
	<20050525204107.722504bd.akpm@osdl.org>
	<1117093392l.17165l.0l@werewolf.able.es>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> 
> On 05.26, Andrew Morton wrote:
> > 
> > (Added alsa-devel to cc)
> > 
> > Ed Tomlinson <tomlins@cam.org> wrote:
> > > 
> > > Got the following when I tried to use sound.  Anyone else see problems in alsa land?
> > > 
> 
> Me too. As beep-media-player ends playing a mp3 track, oops !

hm, OK, you're also on x86_64.  What sound card and driver?

> Decoded below, for if it gives additional info:

Actually, no, ksymoops removes info.  Please just send the kernel's oops
output directly.  (Make sure that CONFIG_KALLSYMS=y).

