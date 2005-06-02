Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVFBHjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVFBHjY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 03:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVFBHjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 03:39:24 -0400
Received: from peabody.ximian.com ([130.57.169.10]:29331 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261597AbVFBHjR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 03:39:17 -0400
Subject: Re: Accessing monotonic clock from modules
From: Robert Love <rml@novell.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Mikael Starvik <mikael.starvik@axis.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1117697423.6458.18.camel@laptopd505.fenrus.org>
References: <BFECAF9E178F144FAEF2BF4CE739C66801B7645C@exmail1.se.axis.com>
	 <1117697423.6458.18.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Thu, 02 Jun 2005 03:40:45 -0400
Message-Id: <1117698045.6833.16.camel@jenny.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-02 at 09:30 +0200, Arjan van de Ven wrote:
> On Thu, 2005-06-02 at 08:36 +0200, Mikael Starvik wrote:
> > We would like to get the posix monotonic clock from a loadable module.
> > Would a patch to make do_posix_clock_monotonic_gettime exported ok or
> > should we do it in some other way?
> > 
> > /Mikael
> 
> also... when are you going to get this module merged?
> (exporting things without the module going into kernel.org shouldn't be
> done imo... it makes it harder to change internals and causes overhead
> for all kernel users)

And if we are going to make it an official interface, does it have to be
called "do_posix_clock_monotonic_gettime" ?  Perhaps a more
export-friendly name?

	Robert Love


