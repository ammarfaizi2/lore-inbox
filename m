Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269589AbTHJOS0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 10:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269619AbTHJOS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 10:18:26 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:32782 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S269589AbTHJOSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 10:18:23 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH][2.6.0-test3] i386 cpuid.c devfs support 2/2
Date: Sun, 10 Aug 2003 18:14:52 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200308101252.26584.arvidjaar@mail.ru> <20030810135939.GB17154@redhat.com>
In-Reply-To: <20030810135939.GB17154@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308101814.52335.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 August 2003 17:59, Dave Jones wrote:
> On Sun, Aug 10, 2003 at 12:52:26PM +0400, Andrey Borzenkov wrote:
>  > the same question about default permissions as for msr.c; the same
>  > problem with module unload.
>
> cpuid is less harmful than msr, but it's possible some admins may not
> want their users being able to read things like CPU serial numbers
> (if enabled).
>

should it be 400 or 440 by default? Microcode sets permissions to 640.

-andrey
