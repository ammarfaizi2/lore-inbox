Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWHQFUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWHQFUf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 01:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWHQFUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 01:20:35 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:11958 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751299AbWHQFUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 01:20:34 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Greg KH <greg@kroah.com>
Subject: Re: [linux-pm] [RFC][PATCH 3/3] PM: Remove PM_TRACE from Kconfig
Date: Thu, 17 Aug 2006 07:24:23 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@suse.cz>, Linux PM <linux-pm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <200608151509.06087.rjw@sisk.pl> <200608161314.11128.rjw@sisk.pl> <20060817044011.GB14127@kroah.com>
In-Reply-To: <20060817044011.GB14127@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608170724.23968.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 August 2006 06:40, Greg KH wrote:
> On Wed, Aug 16, 2006 at 01:14:11PM +0200, Rafael J. Wysocki wrote:
> > Remove the CONFIG_PM_TRACE option, which is dangerous and should only be used
> > by people who know exactly what they are doing, from Kconfig.
> 
> No, don't remove this, that's not acceptable at all.  This is useful for
> others (and one specifically who will be pissed to see this removed...)

Well, this was a Pavel's idea. ;-)

However, it does some harm to users.  I was hit by it personally and there's
been at least one report related to it on LKML recently.

Still I think we can just mark it as dangerous or something like that, which
was my initial idea.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
