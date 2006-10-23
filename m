Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbWJWSae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbWJWSae (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 14:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWJWSae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 14:30:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47561 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964998AbWJWSae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 14:30:34 -0400
Subject: Re: Battery class driver.
From: David Woodhouse <dwmw2@infradead.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, devel@laptop.org, davidz@redhat.com,
       greg@kroah.com, len.brown@intel.com, sfr@canb.auug.org.au,
       benh@kernel.crashing.org
In-Reply-To: <20061023182635.GA19139@srcf.ucam.org>
References: <1161627633.19446.387.camel@pmac.infradead.org>
	 <20061023182635.GA19139@srcf.ucam.org>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 19:30:31 +0100
Message-Id: <1161628231.19446.390.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-23 at 19:26 +0100, Matthew Garrett wrote:
> Without commenting on the rest:
> 
> The tp_smapi code also provides average current and power, the charge 
> cycle count, the date of first use, the date of manufacture and controls 
> for altering the charge behaviour of the battery. Are these things that 
> should go in the generic class?

Yes, almost certainly. I went looking for what ACPI, PMU and of course
OLPC provided, but missed the others.

-- 
dwmw2

