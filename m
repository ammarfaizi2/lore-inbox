Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbVAOBYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbVAOBYG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 20:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbVAOBVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 20:21:05 -0500
Received: from opersys.com ([64.40.108.71]:62472 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262103AbVAOBRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 20:17:54 -0500
Message-ID: <41E87102.2090502@opersys.com>
Date: Fri, 14 Jan 2005 20:25:22 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org>	 <1105740276.8604.83.camel@tglx.tec.linutronix.de>	 <41E85123.7080005@opersys.com>	 <1105747280.13265.72.camel@tglx.tec.linutronix.de>	 <20050114162652.73283f2e.akpm@osdl.org> <1105750810.13265.126.camel@tglx.tec.linutronix.de>
In-Reply-To: <1105750810.13265.126.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas Gleixner wrote:
> I do not accept unnecessary complexity in the kernel, when you are able
> to achieve the same goal by putting more thoughts into the
> postprocessing. The kernel code is responsible to provide a simple and
> fast interface for those tasks and nothing more. I don't see the point
> why we need 150k additional code with limitations/problems, which are
> even obvious without running it, instead of a simple interface to
> userland where different postprocessors can compete to do the job more
> or less perfect.

You have previously demonstrated that you do not understand the
implementation you are criticizing. You keep repeating the size
of the patch like a mantra, yet when pressed for actual bits of
code that need fixing, you use a circular argument to slip away.

If you feel that there is some unncessary processing being done
in the kernel, please show me the piece of code affected so that
it can be fixed if it is broken.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
