Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbTH2TEt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 15:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbTH2TEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 15:04:48 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:41909 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261809AbTH2TEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 15:04:47 -0400
Subject: Re: /proc/ioports overrun patch
From: john stultz <johnstul@us.ibm.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: olof@austin.ibm.com, lkml <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.55L.0308291025340.21063@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0308291025340.21063@freak.distro.conectiva>
Content-Type: text/plain
Organization: 
Message-Id: <1062183578.1307.1400.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 29 Aug 2003 11:59:39 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-29 at 06:30, Marcelo Tosatti wrote:

> If so, I would prefer to have a fix which outputs the full resource
> information. For that we would need seq_file().

I have a patch that converts /proc/interrupts to use seq_file as well,
however it would be much cleaner if Randy's backport of the "single"
interface went in first  

http://www.ussg.iu.edu/hypermail/linux/kernel/0308.3/0296.html

Are you planning on taking that patch? Or should I just resend my patch
w/o it?

thanks
-john

