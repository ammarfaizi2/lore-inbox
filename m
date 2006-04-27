Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965151AbWD0PXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbWD0PXA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 11:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbWD0PXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 11:23:00 -0400
Received: from xenotime.net ([66.160.160.81]:38080 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965151AbWD0PW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 11:22:59 -0400
Date: Thu, 27 Apr 2006 08:25:25 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH -mm] W1_CON: add W1 to depends
Message-Id: <20060427082525.4b1ee4db.rdunlap@xenotime.net>
In-Reply-To: <20060427125745.GA12840@2ka.mipt.ru>
References: <20060426212131.1c566d19.rdunlap@xenotime.net>
	<20060427125745.GA12840@2ka.mipt.ru>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Apr 2006 16:57:45 +0400 Evgeniy Polyakov wrote:

> On Wed, Apr 26, 2006 at 09:21:31PM -0700, Randy.Dunlap (rdunlap@xenotime.net) wrote:
> > From: Randy Dunlap <rdunlap@xenotime.net>
> > 
> > W1_CON should depend on W1 also.
> 
> I have no problem with the patch, but does dependency absence introduce
> some problems? This config option is only used when w1 is enabled.

Not quite true, or I wouldn't have seen a problem and sent a patch
for it.
With W1 disabled and doing 'make oldconfig', I got a prompt for

  Userspace communication over connector (W1_CON)? [Y/m/n]

which shouldn't happen.

---
~Randy
