Return-Path: <linux-kernel-owner+w=401wt.eu-S1946048AbWLVL0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946048AbWLVL0f (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 06:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946044AbWLVL0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 06:26:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38468 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946041AbWLVL0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 06:26:34 -0500
Subject: Re: [PATCH 2/10] cxgb3 - main source file
From: Arjan van de Ven <arjan@infradead.org>
To: Divy Le Ray <divy@chelsio.com>
Cc: Divy Le Ray <None@chelsio.com>, jeff@garzik.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, swise@opengridcomputing.com
In-Reply-To: <458B86A7.6030402@chelsio.com>
References: <20061220124134.6299.29373.stgit@localhost.localdomain>
	 <1166623330.3365.1397.camel@laptopd505.fenrus.org>
	 <4589CA9C.80007@chelsio.com>
	 <1166688978.3365.1472.camel@laptopd505.fenrus.org>
	 <458B86A7.6030402@chelsio.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 22 Dec 2006 12:26:03 +0100
Message-Id: <1166786763.3365.1549.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Using request_firmware assumes that the driver knows the FW file name

no it knows an ALIAS for it.

> and the driver initiates the load. That's not our model where we work
> with different FWs, don't know what the names are,

you can have the user make a symlink to the one he wants. No Big Deal.


>  and the user 
> initiates the load.

that sounds broken, but you can have a sysfs parameter for "load now";
cpu microcode has something like that as well..

but are you really sure you don't want to just do the load at "up"
time ?


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

