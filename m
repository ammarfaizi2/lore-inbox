Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVFMSrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVFMSrU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 14:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVFMSrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 14:47:19 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:51410 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S261195AbVFMSpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 14:45:32 -0400
Date: Mon, 13 Jun 2005 14:45:44 -0400
From: Mark Bidewell <mark.bidewell@alumni.clemson.edu>
Subject: kernel 2.6.11.12 I2C error
To: linux-kernel@vger.kernel.org
Message-id: <42ADD458.3090906@alumni.clemson.edu>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I attempt to compile 2.6.11.12 from a full download. I get the 
following messages:

include/linux/i2c.h:58: error: array type has incomplete element type
include/linux/i2c.h:197: error: array type has incomplete element type

I think the problem has to do with the forward declartion used in those 
lines. 

I am using gcc 4.0 on FC4 final

Mark Bidewell
