Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264793AbTFLJCs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 05:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264796AbTFLJCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 05:02:48 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:8099 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S264793AbTFLJCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 05:02:47 -0400
Message-Id: <5.1.0.14.2.20030612111202.00aee2b8@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 12 Jun 2003 11:16:33 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: [PATCH] More i2c driver changes for 2.5.70
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: bKXTkqZ6ged10FlMNsvXgKMkJ9ZRngW9UlRf4IdXHk2R7G6bRC89wf@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I think there is a race condition here in the "set" functions.
Hi Philip, long time no see :-)
Yes, you are right.
Will be sending a patch to Greg shortly.
Couple of other things have to be fixed as well.
Just realized that temp scaling is wrong.
Should be scaling by 1000 not 100.
(Gee, and that after I had mailed Greg that a couple of other sensors
get it wrong)

Margit

