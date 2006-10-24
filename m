Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbWJXDld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbWJXDld (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 23:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbWJXDld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 23:41:33 -0400
Received: from gate.crashing.org ([63.228.1.57]:19663 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964974AbWJXDlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 23:41:32 -0400
Subject: Re: Battery class driver.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       olpc-dev@laptop.org, davidz@redhat.com, greg@kroah.com,
       len.brown@intel.com, sfr@canb.auug.org.au
In-Reply-To: <20061023182635.GA19139@srcf.ucam.org>
References: <1161627633.19446.387.camel@pmac.infradead.org>
	 <20061023182635.GA19139@srcf.ucam.org>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 13:36:18 +1000
Message-Id: <1161660978.10524.537.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The tp_smapi code also provides average current and power, the charge 
> cycle count, the date of first use, the date of manufacture and controls 
> for altering the charge behaviour of the battery. Are these things that 
> should go in the generic class?

Also, should we create files for things that the backend doesn't
provide ? Seems like a waste of memory to me.

Ben


