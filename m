Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932688AbVJ0XSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932688AbVJ0XSv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 19:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932689AbVJ0XSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 19:18:51 -0400
Received: from maggie.cs.pitt.edu ([130.49.220.148]:28893 "EHLO
	maggie.cs.pitt.edu") by vger.kernel.org with ESMTP id S932688AbVJ0XSu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 19:18:50 -0400
From: Claudio Scordino <cloud.of.andor@gmail.com>
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: The "best" value of HZ
Date: Fri, 28 Oct 2005 01:18:41 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200510280118.42731.cloud.of.andor@gmail.com>
X-Spam-Score: -1.665/8 BAYES_00 SA-version=3.000002
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    during the last years there has been a lot of discussion about the "best" 
value of HZ... On i386 was 100, then became 1000, and finally was set to 250.
I'm thinking to do an evaluation of this parameter using different 
architectures.

Has anybody thought to give the possibility to modify the value of HZ at boot 
time instead of at compile time ? This would allow to easily test different 
values on different machines and create a table containing the "best" value 
for each architecture...  At this moment, instead, we have to recompile the 
kernel for each different value :(

Do you think there would be much work to do that ? 
Do you think it would be a desired feature the knowledge of the best value for 
each architecture with more precision ?

Thanks,

      Claudio
