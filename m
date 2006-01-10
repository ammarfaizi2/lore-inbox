Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWAJBHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWAJBHS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 20:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWAJBHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 20:07:18 -0500
Received: from maggie.cs.pitt.edu ([130.49.220.148]:63679 "EHLO
	maggie.cs.pitt.edu") by vger.kernel.org with ESMTP id S932137AbWAJBHR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 20:07:17 -0500
From: Claudio Scordino <cloud.of.andor@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Need help: hook for executing task
Date: Mon, 9 Jan 2006 20:07:14 -0500
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601092007.14827.cloud.of.andor@gmail.com>
X-Spam-Score: -1.665/8 BAYES_00 SA-version=3.000002
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have to develop some real-time code. I need to execute some code *any* time 
the executing task changes.

I already tried to put a hook in the __schedule() function, before the call to 
the context_switch() function. 

However, my code is called two consecutive times with the same prev or the 
same next: seems that between two consecutive calls someone has changed the 
executing task...

Can somebody please tell me where exactly I should put my hook ??

Many thanks,

           Claudio Scordino
