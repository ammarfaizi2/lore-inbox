Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262401AbVHCTFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbVHCTFX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 15:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbVHCTFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 15:05:23 -0400
Received: from vena.lwn.net ([206.168.112.25]:40920 "HELO lwn.net")
	by vger.kernel.org with SMTP id S262401AbVHCTFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 15:05:21 -0400
Message-ID: <20050803190521.7544.qmail@lwn.net>
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 partition support driver methods 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Wed, 03 Aug 2005 19:53:01 +0530."
             <C349E772C72290419567CFD84C26E0170423A6@mail.esn.co.in> 
Date: Wed, 03 Aug 2005 13:05:21 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do I need to handle any thing in the request function to handle
> read/writes to the device partitions? 

It looks like you've done most of what you need; in 2.6, block drivers
need not worry about the details of partitioning.

Lots of details in the block drivers chapter of LDD3 if you need them:

	http://lwn.net/Kernel/LDD3/

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net

