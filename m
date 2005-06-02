Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVFBVwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVFBVwD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 17:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVFBVuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 17:50:23 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:59325 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261312AbVFBVo0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 17:44:26 -0400
Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell
	BIOS update driver
From: Marcel Holtmann <marcel@holtmann.org>
To: Abhay Salunke <Abhay_Salunke@dell.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       matt_domsch@dell.com, Greg KH <greg@kroah.com>
In-Reply-To: <20050602183648.GA31701@littleblue.us.dell.com>
References: <20050602183648.GA31701@littleblue.us.dell.com>
Content-Type: text/plain
Date: Thu, 02 Jun 2005 23:44:08 +0200
Message-Id: <1117748648.3656.10.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhay,

> This is a resubmit of the patch after incorporating all the inputs from revieweres. 
> This has the hotplug firmware interface as suggested by many. 
> Currently it does not suport reading back the data; I am workingon it and will add 
> that feature as new patch.

please fix the coding style. We use tabs instead of spaces.

Make sure that all functions are static and clean your namespace. Even
if they are static it is still unclean.

It is <linux/firmware.h> and not "linux/firmware.h".

The Kconfig is missing a "select FW_LOADER".

Regards

Marcel


