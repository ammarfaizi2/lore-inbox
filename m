Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbUCLEo2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 23:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbUCLEo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 23:44:27 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:32435 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261950AbUCLEo0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 23:44:26 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: George Anzinger <george@mvista.com>
Subject: Re: [Kgdb-bugreport] [PATCH][2/3] Update CVS KGDB's have kgdb_{schedule,process}_breakpoint
Date: Fri, 12 Mar 2004 10:14:08 +0530
User-Agent: KMail/1.5
Cc: Tom Rini <trini@kernel.crashing.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, kgdb-bugreport@lists.sourceforge.net
References: <20040225213626.GF1052@smtp.west.cox.net> <200403041028.33638.amitkale@emsyssoft.com> <4050D9EE.2070800@mvista.com>
In-Reply-To: <4050D9EE.2070800@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403121014.08221.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 Mar 2004 2:58 am, George Anzinger wrote:
> Amit S. Kale wrote:
> ~
>
> >>context any
> >>
> >>p fun()
> >
> > p fun() will push arguments on stack over the place where irq occured,
> > which is exactly how it'll run.
>
> Is this capability in kgdb lite?  It was one of the last things I added to
> -mm version.

No! It's not present in kgdb heavy also. All you can do is set $pc, continue.

-Amit

