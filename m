Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264468AbTLCBck (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 20:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264470AbTLCBck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 20:32:40 -0500
Received: from hqemgate00.nvidia.com ([216.228.112.144]:48653 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S264468AbTLCBcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 20:32:39 -0500
Message-ID: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F86E@mail-sc-6.nvidia.com>
From: Allen Martin <AMartin@nvidia.com>
To: "'b@netzentry.com'" <b@netzentry.com>, pomac@vapor.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: NForce2 pseudoscience stability testing (2.6.0-test11)
Date: Tue, 2 Dec 2003 17:32:27 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: b@netzentry.com [mailto:b@netzentry.com] 
> Sent: Tuesday, December 02, 2003 5:23 PM
> How is the performance of the generic IDE driver?
> 
> My experience that it was almost unusable (kernel 2.4.22,
> 2.4.23) (fsck taking hours, etc)
> 

You won't be able to use DMA without the AMD/nForce driver, so yes it will
be very slow.  I'd try the add-in card if you have one available, it will be
more similar to the config that fails but just with a different controller.

-Allen
