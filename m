Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbVLSRmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbVLSRmO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 12:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbVLSRmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 12:42:14 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:7040 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932287AbVLSRmN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 12:42:13 -0500
Subject: Re: Kernel interrupts disable at user level - RIGHT/ WRONG - Help
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AEC1E10243A314391FE9C01CD65429B223248@mail.esn.co.in>
References: <3AEC1E10243A314391FE9C01CD65429B223248@mail.esn.co.in>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Dec 2005 17:42:49 +0000
Message-Id: <1135014170.6051.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-12-19 at 17:45 +0530, Mukund JB. wrote:
> Dear Kernel Developers,
> 
> I have a requirement of getting the CMOS details at the user level. I have identified the interfaces as /dev/nvram & /dev/rtc.
> But, the complete CMOS details are available to the user Applications as the driver does not provide the suitable interface to get the complete CMOS details.

Then you'll need to enhance the nvram or rtc driver to support the extra
bits you need. What doesn't it provide access to that you require >

