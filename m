Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbUKSEIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbUKSEIP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 23:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbUKSEIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 23:08:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35299 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261246AbUKSEIM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 23:08:12 -0500
Message-ID: <419D719B.1090408@pobox.com>
Date: Thu, 18 Nov 2004 23:07:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Edward Falk <efalk@google.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE ioctl documentation & a new ioctl
References: <419D5CE6.8030503@google.com>
In-Reply-To: <419D5CE6.8030503@google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edward Falk wrote:
> And while I'm on the subject, we're getting ready to write a new hdio 
> ioctl, an extension of HDIO_DRIVE_CMD.  The intent here is to be 
> slightly more general-purpose than HDIO_DRIVE_CMD, with an eye to 
> supporting the full set of SMART functionality.  Current plan is to have 
> the user pass a struct containing a pointer to the argument list, a 
> pointer to the data buffer, and a data buffer length value.  Consider 
> this a design document; any comments and/or feature requests?

HDIO_DRIVE_TASK and flagged taskfiles should cover everything you need.

	Jeff


