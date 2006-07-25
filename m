Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWGYP07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWGYP07 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 11:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWGYP07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 11:26:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:46889 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S964777AbWGYP06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 11:26:58 -0400
X-IronPort-AV: i="4.07,180,1151910000"; 
   d="scan'208"; a="103858755:sNHT18199685"
Date: Tue, 25 Jul 2006 08:17:37 -0700
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: George Nychis <gnychis@cmu.edu>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@osdl.org
Subject: Re: ACPI bombing, ACPI Exception (acpi_bus-0071): AE_NOT_FOUND
Message-Id: <20060725081737.edb715c6.kristen.c.accardi@intel.com>
In-Reply-To: <44C13563.4010307@cmu.edu>
References: <44C13563.4010307@cmu.edu>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2006 16:13:23 -0400
George Nychis <gnychis@cmu.edu> wrote:

> Hey guys,
> 
> I am running a 2.6.18-rc1-git7 kernel on my IBM Thinkpad x60s, with
> CONFIG_ACPI_DOCK=y
> 
> Whenever the computer is inserted into the dock, ACPI seems to bomb:
> http://rafb.net/paste/results/GW5E8747.html
> 
> I was wondering if anyone could help me solve this problem, I believe it
> is keeping me from using my cdrom drive on the dock since it does not
> show up in /dev.  I have also contacted Kristen Accardi about it, who I
> believe wrote the dock code... but I wasn't sure if this is a further
> problem in ACPI somewhere.
> 
> Here is my full config:
> http://rafb.net/paste/results/o2gSVu90.html
> 
> Thanks!
> George
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Hello everyone,
I am working on getting an x60 to duplicate the cdrom issue this week.  However, I was wondering if there was anything we could do about these AE_NOT_FOUND messages.  A lot of people believe that they are errors, but in fact they are normal for hotplugging.  Would it be ok if I just get rid of that error message?  It generates unneccessary consternation.

Kristen
