Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbTFXJAH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 05:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbTFXJAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 05:00:07 -0400
Received: from [195.141.226.27] ([195.141.226.27]:59406 "EHLO
	netline-mail1.netline.ch") by vger.kernel.org with ESMTP
	id S261182AbTFXJAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 05:00:05 -0400
Subject: Re: [Dri-devel] radeon drm in 2.5.73
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Warren Turkal <wturkal@cbu.edu>
Cc: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <200306232153.43956.wturkal@cbu.edu>
References: <200306232153.43956.wturkal@cbu.edu>
Content-Type: text/plain; charset=ISO-8859-1
Organization: Debian, XFree86
Message-Id: <1056446049.30617.14.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 24 Jun 2003 11:14:09 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-24 at 04:53, Warren Turkal wrote:
> I have a problem with the radeon drm in kernel 2.5.73. When modprobing the 
> module, it comes back with "radeon: Unknown symbol flush_tlb_all" and won't 
> load. This has been happening for at least 5 kernel versions I believe. Is 
> there a known fix or patch that has not made it into the kernel proper?

I guess

EXPORT_SYMBOL(flush_tlb_all);

needs to be added to some *ksyms*.c .


-- 
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer

