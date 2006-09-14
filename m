Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWINHGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWINHGi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 03:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWINHGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 03:06:38 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:10459 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751378AbWINHGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 03:06:37 -0400
Date: Thu, 14 Sep 2006 09:06:57 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Greg K-H <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [03/12] driver core fixes: fixup
 platform_device_register_simple()
Message-ID: <20060914090657.03587ffd@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <200609132231.06346.dtor@insightbb.com>
References: <20060913163007.21cf10a8@gondolin.boeblingen.de.ibm.com>
	<20060913183840.5a2e4989@gondolin.boeblingen.de.ibm.com>
	<200609132231.06346.dtor@insightbb.com>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2006 22:31:05 -0400,
Dmitry Torokhov <dtor@insightbb.com> wrote:

> platform_device_add() already releases all resources in case of failure.
> Memory allocated for resource structures is released by
> platform_device_release(). I do not think this patch is needed.

Uh, of course, you're right.

Greg, please disregard this patch.

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
