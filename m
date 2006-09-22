Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbWIVON7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbWIVON7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 10:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbWIVON6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 10:13:58 -0400
Received: from smtp.reflexsecurity.com ([72.54.64.74]:54509 "EHLO
	crown.reflexsecurity.com") by vger.kernel.org with ESMTP
	id S932511AbWIVON6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 10:13:58 -0400
Date: Fri, 22 Sep 2006 10:13:47 -0400
From: Jason Lunz <lunz@falooley.org>
To: "Rafael J\. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>
Subject: Re: [PATCH -mm 5/6] mm: Print first block offset for swap areas
Message-ID: <20060922141346.GA28949@opus.vpn-dev.reflex>
References: <20060921235340.DBD89822B@knob.reflex> <20060921235817.GA27170@knob.reflex> <200609221257.12303.rjw@sisk.pl>
In-Reply-To: <200609221257.12303.rjw@sisk.pl>
User-Agent: Mutt/1.5.13 (2006-08-11)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 12:57:11PM +0200, Rafael J. Wysocki wrote:
> This is filesystem-dependent.  AFAICT not all filesystems are supported
> by GRUB.

of course, but it shows the technique is viable. Grub is 
widespread, and if it's good enough for so many x86 users to boot with
then the same approach ought to be adequate for resume, no?

Jason
