Return-Path: <linux-kernel-owner+w=401wt.eu-S1422846AbWLUIQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422846AbWLUIQd (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 03:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422842AbWLUIQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 03:16:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:35660 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422839AbWLUIQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 03:16:32 -0500
Subject: Re: [PATCH 2/10] cxgb3 - main source file
From: Arjan van de Ven <arjan@infradead.org>
To: Divy Le Ray <divy@chelsio.com>
Cc: Divy Le Ray <None@chelsio.com>, jeff@garzik.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, swise@opengridcomputing.com
In-Reply-To: <4589CA9C.80007@chelsio.com>
References: <20061220124134.6299.29373.stgit@localhost.localdomain>
	 <1166623330.3365.1397.camel@laptopd505.fenrus.org>
	 <4589CA9C.80007@chelsio.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 21 Dec 2006 09:16:18 +0100
Message-Id: <1166688978.3365.1472.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> They are used to parameter the HW:
> register access,

ethtool supports that, so shouldn't be an ioctl for sure

>  configuration of queue sets, on board memory 
> configuration,

I'm sure ethtool can do that too

> firmware load, etc ...

and for this we have request_firmware() interface. 

adding device specific ioctl that duplicate functionality that exists or
should exist in a generic way isn't really acceptable for 2.6 kernels
anymore....



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

