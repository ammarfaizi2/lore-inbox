Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266395AbUBSHxE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 02:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266647AbUBSHxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 02:53:04 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:60608 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S266395AbUBSHxB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 02:53:01 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Pavel Machek <pavel@suse.cz>, trini@kernel.crashing.org,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Split kgdb into "lite" and "normal" parts
Date: Thu, 19 Feb 2004 13:22:52 +0530
User-Agent: KMail/1.5
References: <20040218225010.GH321@elf.ucw.cz>
In-Reply-To: <20040218225010.GH321@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402191322.52499.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Tested (core-lite.patch + i386-lite.patch + 8250.patch) combination.
Looks good.

Let's first check this in and then do more cleanups.
Tom, does it sound ok?

-Amit

On Thursday 19 Feb 2004 4:20 am, Pavel Machek wrote:
> Hi!
>
> This is based on current CVS version. If you want just basic
> functionality, apply core-lite.patch and i386-lite.patch. If you want
> all the features, add core.patch and i386.patch.
>
> Amit, this should be "step 1: split" we were talking about. Could you
> test it looks sane and add it to the cvs?
> 							Pavel

