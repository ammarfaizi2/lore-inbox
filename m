Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbWDVTTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWDVTTj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWDVTTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:19:39 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58124 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751001AbWDVTTh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:19:37 -0400
Date: Thu, 20 Apr 2006 22:01:43 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: Xavier Bestel <xavier.bestel@free.fr>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Message-ID: <20060420220142.GC2352@ucw.cz>
References: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com> <20060420073713.GA25735@srcf.ucam.org> <4447AA59.8010300@linux.intel.com> <20060420153848.GA29726@srcf.ucam.org> <4447AF4D.7030507@linux.intel.com> <1145549460.23837.156.camel@capoeira> <4447B7D6.4030401@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4447B7D6.4030401@linux.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 20-04-06 20:33:26, Alexey Starikovskiy wrote:
> Xavier Bestel wrote:
> >There are keyboards with power/sleep buttons. It makes 
> >sense they have
> >the same behavior than ACPI buttons.
> Agree, make them behave like ACPI buttons -- remove them 
> from input stream, as they do not belong there...

So you propose to

a) break backwards compatibility

b) introduce not-yet-existing mechanism for delivering events to
userspace

when you have perfectly working interface (input) you can just use?
Not a good idea, I'd say.
-- 
Thanks, Sharp!
