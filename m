Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVFBHv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVFBHv3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 03:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVFBHv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 03:51:29 -0400
Received: from peabody.ximian.com ([130.57.169.10]:35731 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261604AbVFBHvT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 03:51:19 -0400
Subject: Re: Accessing monotonic clock from modules
From: Robert Love <rml@novell.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Mikael Starvik <mikael.starvik@axis.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1117698518.6458.21.camel@laptopd505.fenrus.org>
References: <BFECAF9E178F144FAEF2BF4CE739C66801B7645C@exmail1.se.axis.com>
	 <1117697423.6458.18.camel@laptopd505.fenrus.org>
	 <1117698045.6833.16.camel@jenny.boston.ximian.com>
	 <1117698518.6458.21.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Thu, 02 Jun 2005 03:52:44 -0400
Message-Id: <1117698764.6833.26.camel@jenny.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-02 at 09:48 +0200, Arjan van de Ven wrote:

> agreed.
> 
> well maybe it doesn't have such a name since it isn't intended as such
> interface....

That was the root of my concern; if the interface is more of a "do"
function, maybe we need something cleaner as the officially exported
interface?  With, of course, a better name. ;-)

I do thing that this is useful, though--at GUADEC I talked with some
folks who really want to get at a good clock source, the same from both
the kernel and user-space.

	Robert Love


