Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263903AbTCUTqs>; Fri, 21 Mar 2003 14:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263895AbTCUTpW>; Fri, 21 Mar 2003 14:45:22 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:21777
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263892AbTCUTow>; Fri, 21 Mar 2003 14:44:52 -0500
Subject: Re: Preempt switchable.
From: Robert Love <rml@tech9.net>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.51.0303212047100.11545@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0303212047100.11545@dns.toxicfilms.tv>
Content-Type: text/plain
Organization: 
Message-Id: <1048276554.4908.31.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 21 Mar 2003 14:55:55 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-21 at 14:48, Maciej Soltysiak wrote:

> would it be possible to turn on/off CONFIG_PREEMPT at runtime, eg. via
> sysctl ?

Sure, make a sysctl and check it in preempt_schedule() and
ret_from_kernel in entry.S before invoking schedule().

But that is not pretty, and I do not think it should go in mainline. 
Linus has said as much, too.

	Robert Love

