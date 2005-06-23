Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262244AbVFWLIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbVFWLIl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 07:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVFWLIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 07:08:40 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:39176 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S262244AbVFWLI1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 07:08:27 -0400
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem compiling 2.6.12
References: <200506222037.17738.nick@linicks.net>
	<20050622213038.GA3749@stusta.de>
	<200506222253.47777.nick@linicks.net>
From: Nix <nix@esperi.org.uk>
X-Emacs: or perhaps you'd prefer Russian Roulette, after all?
Date: Thu, 23 Jun 2005 12:08:13 +0100
In-Reply-To: <200506222253.47777.nick@linicks.net> (Nick Warne's message of
 "22 Jun 2005 23:13:10 +0100")
Message-ID: <87r7et2uw2.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jun 2005, Nick Warne stipulated:
> Is it?  I thought kernel didn't care what Glibc or what kernel headers you had 
> (that is system requirement) - it is automous.  Isn't HOSTCC explicitly just 
> what compiler you have?

HOSTCC is a non-cross-compiler, i.e. for building userspace stuff to run
on the build machine. There are a number of such things built during a
normal kernel build (code generators, the config system, et al) and they
use the C library just like any userspace app does.

-- 
`It's as bizarre an intrusion as, I don't know, the hobbits coming home
 to find that the Shire has been taken over by gangsta rappers.'
