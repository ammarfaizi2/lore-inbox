Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWIBAoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWIBAoD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 20:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWIBAoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 20:44:03 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:7859 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750761AbWIBAoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 20:44:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=icjEnn8fn4wGAe6AE0r01eSI2eEvvQHkFJWJRCHdfcciOhu2U1JXp6xvPmtTbK4AjQADFpsUZ6CIa2EYRcSAbIn411J6LqUXJv6dNYOJHCnVryyAsX1QkL0LPWOkodtYd3VZtRtKUSHAM/j5Zz9t2XIZdCGOMvv5O6k74xx4Z0g=
Message-ID: <ea0b05b30609011744g1d68e964s726cf86d2e72a34b@mail.gmail.com>
Date: Fri, 1 Sep 2006 17:44:01 -0700
From: Ethan <thesyntheticsophist@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: File corruption with 2940U2 SCSI card and aic7xxx driver.
In-Reply-To: <1157151927.6271.341.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <ea0b05b30609010905v341ba10ap5a7638e1d91faa5b@mail.gmail.com>
	 <1157151927.6271.341.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does this still occur with a more recent upstream kernel ?

I've tried kernel version 2.6.16 (with version 7 of the aic7xxx
driver).  Same problem.

>
>
> There are also known AHA2940 incompatibilities with a few boards. People
> always had problems with CUV4X* boards for one. Bit early to assume its
> the board however it might be worth making sure the card is well seated
> and the cabling looks good. That said I'd expect parity errors..
>

I've tried two different PCI slots and two different SCSI cables.
Same problem.  I've enabled PCI parity checking via the pci_parity
option to the aic7xxx driver, but I don't see any parity errors in the
kernel messages.

I'm having trouble believing that this could be a hardware problem
because I can consistently read data from the SCSI disks, the
corruption only seems to happen during writes.

Thanks for your suggestions.

-- 
VGER BF report: H 1.90148e-11
