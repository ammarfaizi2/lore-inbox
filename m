Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266570AbUFWQyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266570AbUFWQyR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 12:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266566AbUFWQyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 12:54:17 -0400
Received: from fmr10.intel.com ([192.55.52.30]:7314 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S266570AbUFWQyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 12:54:15 -0400
Subject: Re: [PATCH 5/6] 2.6.7-mm1, remove unused ASUS K7V-RM DMI quirk
From: Len Brown <len.brown@intel.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrey Panin <pazke@donpac.ru>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <40D9996C.3080904@pobox.com>
References: <10879946911371@donpac.ru>  <40D9996C.3080904@pobox.com>
Content-Type: text/plain
Organization: 
Message-Id: <1088009583.4319.289.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 23 Jun 2004 12:53:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-23 at 10:53, Jeff Garzik wrote:
> Andrey Panin wrote:
> > BROKEN_ACPI_Sx flag doesn't seem to be used anywhere in the kernel,
> > so ASUS K7V-RM can be removed.
> >... 
> 
> Maybe CC Len Brown on this, to see if he screams?  :)

Dead code, go ahead and clean it out.

Indeed, in the upstream kernel, I'm thinking about deleting
all the ACPI related blacklist entries.
Maintaining them is more trouble than it is worth.
When they do work, they generally are masking bugs
that we should instead fix.

thanks,
-Len


