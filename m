Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbTFWSnh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 14:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266097AbTFWSng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 14:43:36 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:34703 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266096AbTFWSna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 14:43:30 -0400
Subject: Re: My 2.5.73 kernel is losing time
From: john stultz <johnstul@us.ibm.com>
To: Pierre Machard <pmachard@tuxfamily.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030623132803.GC3774@twinette.migus.eu.org>
References: <20030623132803.GC3774@twinette.migus.eu.org>
Content-Type: text/plain
Organization: 
Message-Id: <1056394207.1027.37.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Jun 2003 11:50:07 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-23 at 06:28, Pierre Machard wrote:

> I am sorry but I cannot find the origin of the problem. Since 2.5.70, my
> kernel has a lot of problems with its clock.
[snip]
> I am running an AuthenticAMD  mobile AMD Duron(tm) Processor with an ALi
> Corporation M1647 Northbridge 


Boot w/ "clock=pit" for now as a workaround. 

If you're interested, check out bugme bug 827
http://bugme.osdl.org/show_bug.cgi?id=827 for more details and if you're
feeling adventurous you could help test the patch I'm working on to fix
this. 

thanks
-john


