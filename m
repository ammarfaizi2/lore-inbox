Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbVD0W2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbVD0W2N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 18:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbVD0W1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 18:27:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:45519 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262066AbVD0WYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 18:24:48 -0400
Date: Wed, 27 Apr 2005 15:23:11 -0700
From: Greg KH <greg@kroah.com>
To: Kylene Hall <kjhall@us.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH: 1 of 12] Fix concerns with TPM driver -- use enums
Message-ID: <20050427222310.GB6680@kroah.com>
References: <1110415321526@kroah.com> <422FC42B.7@pobox.com> <Pine.LNX.4.61.0504271407050.3929@jo.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504271407050.3929@jo.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 05:15:46PM -0500, Kylene Hall wrote:
>  /* Atmel definitions */
> -#define	TPM_ATML_BASE			0x400
> +enum {
> +	TPM_ATML_BASE = 0x400
> +};

Please name your enumerated types, so that you can try to check for
type-safeness on them.  Just converting them to a enum doesn't do really
anything...

thanks,

greg k-h
