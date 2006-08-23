Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965180AbWHWUFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965180AbWHWUFM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 16:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbWHWUFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 16:05:12 -0400
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:60347 "EHLO
	mail1.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S965180AbWHWUFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 16:05:10 -0400
Date: Wed, 23 Aug 2006 16:05:08 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Eric Paris <eparis@redhat.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, sds@tycho.nsa.gov,
       James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] SELinux: 2/3 change isec semaphore to a mutex
In-Reply-To: <1156362635.6662.50.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0608231605010.5728@d.namei>
References: <1156362635.6662.50.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006, Eric Paris wrote:

> This patch converts the remaining isec->sem into a mutex.  Very similar
> locking is provided as before only in the faster smaller mutex rather
> than a semaphore.  An out_unlock path is introduced rather than the
> conditional unlocking found in the original code.
> 
> This is being targeted for 2.6.19
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Acked-by: James Morris <jmorris@namei.org>


-- 
James Morris
<jmorris@namei.org>
