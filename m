Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264463AbTDXW4a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 18:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264466AbTDXW4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 18:56:30 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:54442 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264463AbTDXW43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 18:56:29 -0400
Date: Thu, 24 Apr 2003 16:10:28 -0700
From: Greg KH <greg@kroah.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, Soos Peter <sp@osb.hu>
Subject: Re: [PATCH 2.4] dmi_ident made public
Message-ID: <20030424231028.GA29393@kroah.com>
References: <20030424184759.5f7b3323.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424184759.5f7b3323.khali@linux-fr.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 06:47:59PM +0200, Jean Delvare wrote:
> 
> If this patch is accepted and applied, I'll work together with Peter to
> get the three above-mentioned modules simplified, as well as any other I
> may have missed. Also, I'll take care of porting this patch to the 2.5
> series, since it also belongs there.

i2c-piix4 in the 2.5 kernel tree does not need this patch, as everything
it needs to detect IBM laptops is already made public.  See the current
2.5 releases to verify this.

thanks,

greg k-h
