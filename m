Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318368AbSHUQXP>; Wed, 21 Aug 2002 12:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318369AbSHUQXO>; Wed, 21 Aug 2002 12:23:14 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:64270
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S318368AbSHUQXO>; Wed, 21 Aug 2002 12:23:14 -0400
Subject: Re: preempt count -- logging off?
From: Robert Love <rml@tech9.net>
To: Rohan Deshpande <rohan@myeastern.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3D638501.1020108@myeastern.com>
References: <3D638501.1020108@myeastern.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 21 Aug 2002 12:27:22 -0400
Message-Id: <1029947243.858.627.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-21 at 08:18, Rohan Deshpande wrote:
 
> The subject basically says it all .. I want to turn off kernel logging 
> of preempt, but I see no option in kernel config.  It is all over my 
> dmesg and various logs, and I fear it is slowing my system's 
> responsiveness. Any ideas? ex.:
> 
> mozilla[11409] exited with preempt_count 2
> mozilla-bin[18289] exited with preempt_count 3
> mozilla-bin[1531] exited with preempt_count 1
> netstat[28025] exited with preempt_count 3
> xmms[19505] exited with preempt_count 1

Turning this off would be a bad thing, since this is showing you that
you have a problem.

Hm... are you using XFS?

	Robert Love


