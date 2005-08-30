Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbVH3QJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbVH3QJo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 12:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbVH3QJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 12:09:44 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:3251 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932193AbVH3QJo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 12:09:44 -0400
Subject: Re: IDE HPA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg Felix <greg.felix@gmail.com>
Cc: Oliver Tennert <O.Tennert@science-computing.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <87941b4c05083008523cddbb2a@mail.gmail.com>
References: <87941b4c05082913101e15ddda@mail.gmail.com>
	 <200508300859.19701.tennert@science-computing.de>
	 <87941b4c05083008523cddbb2a@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 30 Aug 2005 17:38:47 +0100
Message-Id: <1125419927.8276.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-08-30 at 09:52 -0600, Greg Felix wrote:
> Right.  I get the output at bootup time.  It reads that the HPA is
> 20MB.  Which is exactly the size of how far off the metadata is in
> Linux (once the HPA is disabled).

So your actual problem is nothing to do with the kernel or with the HPA
behaviour ? Whatever tool you are using for raid set up isn't reading
and processing the right fields. 

It isnt the kernels fault if you compute from of end of disk rather than
from end of non reserved area is it ?

