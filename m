Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbTLDOtp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 09:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbTLDOtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 09:49:45 -0500
Received: from houston.jhuapl.edu ([128.244.26.10]:33692 "EHLO
	houston.jhuapl.edu") by vger.kernel.org with ESMTP id S262111AbTLDOto
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 09:49:44 -0500
Date: Thu, 04 Dec 2003 09:49:31 -0500
From: Bernard Collins <bernard.collins@jhuapl.edu>
Subject: Re: Visor USB hang
In-reply-to: <20031204002414.GI21541@kroah.com>
To: Greg KH <greg@kroah.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Message-id: <1070549371.26393.6.camel@collibf1.jhuapl.edu>
Organization: The Johns Hopkins University Applied Physics Laboratory
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.5
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <E37E01957949D611A4C30008C7E691E20915BBFC@aples3.dom1.jhuapl.edu>
 <20031204002414.GI21541@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-12-03 at 19:24, Greg KH wrote:
> 	rmmod usb-uhci && modprobe uhci

OK, this works. The Visor now hotsyncs and I get no hangs or freezes.
Thanks. I am still willing to help track down the problem if you have
any other diagnostic suggestions.

So is there a downside to uhci compared to usb-uhci? Would moving to
kernel 2.6 likely fix the problem? Finally, what is the "right way" to
get my redhat system to permanently use uhci?

