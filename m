Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264025AbTEGPCJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264036AbTEGPCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:02:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:6019 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264025AbTEGPCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:02:07 -0400
Date: Wed, 07 May 2003 07:06:46 -0700 (PDT)
Message-Id: <20030507.070646.54208027.davem@redhat.com>
To: george@mvista.com
Cc: sam@ravnborg.org, akpm@zip.com.au, kbuild-devel@lists.sourceforge.net,
       mec@shout.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic magic
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3EB92176.8010803@mvista.com>
References: <3EB8D36E.10206@mvista.com>
	<20030507143059.GA1057@mars.ravnborg.org>
	<3EB92176.8010803@mvista.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: george anzinger <george@mvista.com>
   Date: Wed, 07 May 2003 08:08:38 -0700
   
   Also, if you are introducing a file with asm code, you either cause
   all "other" archs to fail (till they catch up) or you must
   introduce the simple one line file in each arch.

This is desirable behavior, then the arch maintainer sees the breakage
and if the asm-generic solution is appropriate he makes that
decision.

I don't think you want to play expert for port maintainers.

I sense that you want to be able to do "instant ports" to
some architecture.  This isn't the way to do it.  Instead
tar up a template set of asm-foo/ header files, and dump that
into the directory for your new port.

I see absolutely no value whatsoever to what you are proposing.
In fact, I frankly think it sucks. :(

