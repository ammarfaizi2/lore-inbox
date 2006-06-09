Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbWFIQdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbWFIQdY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWFIQdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:33:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:8312 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030291AbWFIQdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:33:22 -0400
X-IronPort-AV: i="4.05,224,1146466800"; 
   d="scan'208"; a="49680161:sNHT2888701837"
Subject: Re: acpi dock test-drive
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Christian Trefzer <ctrefzer@gmx.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060609144326.GA6093@hermes.uziel.local>
References: <20060609144326.GA6093@hermes.uziel.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 09 Jun 2006 09:45:38 -0700
Message-Id: <1149871538.4542.7.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
X-OriginalArrivalTime: 09 Jun 2006 16:33:16.0656 (UTC) FILETIME=[68F78700:01C68BE2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-09 at 16:43 +0200, Christian Trefzer wrote:
> Hi Kristen,
> 
> finally I had the chance to try out the fruit of your work on my Dell
> Latitude CPiA. First of all, congratulations for the ACPI part, which
> seems to work pretty well so far: the second PCI bridge is detected
> after a hot-dock. However, the PCI devices behind that bridge are not
> yet discovered. Pushing the undock request button on the docking station
> itself results in the PCI bridge being removed again - so far, so good : )
> 
> On the other hand, the undock request caused a reproducible Oops at the
> first time, and kacpid exit the second time. After that, pushing the
> button has no further effect ; )
> 

Hi Christian,
What you are describing sounds like the bug I just fixed :).  Can you
please try 2.6.17-rc6-mm1 to see if this works any better?  I believe it
should resolve both the oops and the fact that your devices behind the
pci bridge are not found.  Thanks very much for continuing to test the
patches.

Kristen
