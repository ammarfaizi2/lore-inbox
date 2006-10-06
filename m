Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWJFIvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWJFIvW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 04:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWJFIvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 04:51:22 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:42979 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751318AbWJFIvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 04:51:21 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -fix] swsusp: Make userland suspend work on SMP again
Date: Fri, 6 Oct 2006 10:52:53 +0200
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <200610042226.43833.rjw@sisk.pl> <20061005164036.06237b30.akpm@osdl.org>
In-Reply-To: <20061005164036.06237b30.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610061052.54690.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 6 October 2006 01:40, Andrew Morton wrote:
> On Wed, 4 Oct 2006 22:26:42 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > Unfortunately one of the recent changes in swsusp has broken the userland
> > suspend on SMP.  Fix it.
> > 
> 
> Which patch does this fix?

Commit e3920fb42c8ddfe63befb54d95c0e13eabacea9b
(Disable CPU hotplug during suspend) in the Linus' tree.
