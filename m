Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752363AbWCFKEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363AbWCFKEU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 05:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752367AbWCFKEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 05:04:20 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:42987 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1752362AbWCFKET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 05:04:19 -0500
Date: Mon, 6 Mar 2006 11:04:16 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, bastian@waldi.eu.org, heiko.carstens@de.ibm.com,
       schwidefsky@de.ibm.com
Subject: Re: + s390-add-modalias-to-uevent-for-ccw-devices.patch added to
 -mm tree
Message-ID: <20060306110416.1e14933f@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <200603060714.k267E6gN021778@shell0.pdx.osdl.net>
References: <200603060714.k267E6gN021778@shell0.pdx.osdl.net>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Mar 2006 23:12:30 -0800
akpm@osdl.org wrote:

> From: Bastian Blank <bastian@waldi.eu.org>
> 
> Add a MODALIAS line to the uevents generated for ccw devices.  udev uses
> them to load modules.
> 
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/s390/cio/device.c |   40 ++++++++++++++++++++++++++----------
>  1 files changed, 29 insertions(+), 11 deletions(-)

Hm, didn't see this on lkml, but the patch looks fine.

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>

Cornelia
