Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161072AbWI1LWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161072AbWI1LWJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 07:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbWI1LWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 07:22:09 -0400
Received: from mail.sanpeople.com ([196.41.13.122]:51973 "EHLO
	za-gw.sanpeople.com") by vger.kernel.org with ESMTP
	id S1161072AbWI1LWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 07:22:05 -0400
Subject: Re: [PATCH 8/8] atmel_serial: Kill at91_register_uart_fns
From: Andrew Victor <andrew@sanpeople.com>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20060928113857.0e3e7c48@cad-250-152.norway.atmel.com>
References: <1159376285670-git-send-email-hskinnemoen@atmel.com>
	 <115937628584-git-send-email-hskinnemoen@atmel.com>
	 <11593762852168-git-send-email-hskinnemoen@atmel.com>
	 <11593762851735-git-send-email-hskinnemoen@atmel.com>
	 <11593762853931-git-send-email-hskinnemoen@atmel.com>
	 <11593762851544-git-send-email-hskinnemoen@atmel.com>
	 <11593762851494-git-send-email-hskinnemoen@atmel.com>
	 <1159376285621-git-send-email-hskinnemoen@atmel.com>
	 <11593762852950-git-send-email-hskinnemoen@atmel.com>
	 <1159435315.23157.73.camel@fuzzie.sanpeople.com>
	 <20060928113857.0e3e7c48@cad-250-152.norway.atmel.com>
Content-Type: text/plain
Organization: Multenet Technologies (Pty) Ltd
Message-Id: <1159442049.23157.94.camel@fuzzie.sanpeople.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 28 Sep 2006 13:14:09 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Haavard,

> Ok, I sort of suspected that. But I can't see any users in the kernel
> tree, so perhaps we should leave the name of the function alone too?
> (i.e. just drop the patch)

For consistency, the function name should be renamed (at91 -> atmel).
I'm not up-to-date with the features of the AVR32-based boards, but this
functionality might also be useful there.

Out-of-mainline users will just have to update their patches.  :)


Regards,
  Andrew Victor


