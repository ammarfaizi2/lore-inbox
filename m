Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263385AbTDVTLp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 15:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263384AbTDVTLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 15:11:45 -0400
Received: from pointblue.com.pl ([62.89.73.6]:41746 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S263385AbTDVTLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 15:11:44 -0400
Subject: Re: Kernel & libc
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200304222101.28725.fsdeveloper@yahoo.de>
References: <Pine.LNX.4.10.10304221529270.15950-100000@soraya.nixe.com>
	 <200304222101.28725.fsdeveloper@yahoo.de>
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1051039421.5030.1.camel@flat41>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 22 Apr 2003 20:23:41 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-22 at 20:01, Michael Buesch wrote:
> On Tuesday 22 April 2003 20:32, aglait@nixe.com wrote:
> > Can you help me ?? 
> maybe :)
> 
> > I want to know if there is a requirement of libc,
> > glibc for kernel 2.4.20 ...
> Kernel doesn't use libc (uses -nostdinc).
> You can't use any library from user-space in kernel.
As long as it is not static included into your module....
Kernel is not able to load libraries nor libc is not writen to function
properly in kernel.

-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

