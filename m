Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWFGEJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWFGEJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 00:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWFGEJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 00:09:56 -0400
Received: from gate.crashing.org ([63.228.1.57]:58243 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750810AbWFGEJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 00:09:55 -0400
Subject: Re: [PATCH  6/9] PCI PM: call platform helpers properly
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adam Belay <abelay@novell.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Len Brown <len.brown@intel.com>
In-Reply-To: <1149648774.7831.217.camel@localhost.localdomain>
References: <1149497171.7831.160.camel@localhost.localdomain>
	 <1149553874.559.2.camel@localhost.localdomain>
	 <1149648774.7831.217.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 14:09:35 +1000
Message-Id: <1149653375.27572.111.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-06 at 22:52 -0400, Adam Belay wrote:

> Hmm, do you know of any example firmware scenarios that make the entire
> state transition?  We might need a separate callback.  I think the
> changes in this patch are at least an improvement over the current
> behavior, especially for ACPI PM functions.  

Well, do we know precisely what ACPI does/needs for example here ?

Ben.


