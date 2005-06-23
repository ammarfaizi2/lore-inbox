Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263184AbVFWIT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbVFWIT1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262685AbVFWIPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:15:41 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:23985 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262619AbVFWHEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 03:04:39 -0400
Date: Thu, 23 Jun 2005 00:04:33 -0700
From: Greg KH <gregkh@suse.de>
To: roger blofeld <blofeldus@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [W1] Fix slave addition on big-endian platform
Message-ID: <20050623070433.GB12158@suse.de>
References: <20050623012732.64286.qmail@web53508.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050623012732.64286.qmail@web53508.mail.yahoo.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 06:27:32PM -0700, roger blofeld wrote:
> Hi
>  In the 2.6.12 code the "rn" structure is in the wrong-endianness when
> passed to w1_attach_slave_device(). This causes problems like the
> family and crc being swapped around. The following patch fixes the
> problem for me.
> 
> Signed-off-by: Roger Blofeld <blofeldus@yahoo.com>

Hm, your patch is line-wrapped and the tabs are missing :(

You should also send this to the w1 author/maintainer first, he would
know if this is the correct fix or not.

thanks,

greg k-h
