Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751693AbWCEFLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbWCEFLU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 00:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbWCEFLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 00:11:19 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:64665 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751677AbWCEFLT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 00:11:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=M8nHZqsd7DJJNsIhQt2Kwb6UIW2N2kgIy2+2GWC3Xrpvazi+zgGyyBBAp9jO8aHg6pAlQuTvxgvInDyZYknPhLmDEwbvHZRYqHx1oP8Um9MeKIvxC5G4f6Z4v6UKeE+svU0Mj+HUNyK6/uuKMhH2AnKgHTBM+yXy8ika/CZzDZU=
Message-ID: <6d6a94c50603042111j7e73de9fi7e8503e47d402bf9@mail.gmail.com>
Date: Sun, 5 Mar 2006 13:11:18 +0800
From: Aubrey <aubreylee@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Quick question: What's the best way to use the existing driver code
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm writing a framebuffer driver, which should be under the folder
"./drivers/video/mydriver.c".
The video controller in my driver need a I2C driver to do some setting.
I found there is already a driver which can be used under the folder
"./drivers/media/video/adv7170.c". Another video driver also uses it.
You see, they are in the different folder and there is no special
configuration menu for the I2C driver "adv7170.c". So, what's the best
way to use the existing driver? Now the easiest way is copying the
driver to my framebuffer folder and add it to the makefile. But I
don't think it's the best way.
Thanks any hints,

Regards,
-Aubrey
