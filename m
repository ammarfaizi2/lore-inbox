Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbTJIKr6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 06:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbTJIKr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 06:47:57 -0400
Received: from mail.convergence.de ([212.84.236.4]:40356 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261518AbTJIKr4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 06:47:56 -0400
Subject: [PATCH 0/7] LinuxTV.org DVB driver update
In-Reply-To: 
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 9 Oct 2003 12:47:54 +0200
Message-Id: <10656964742394@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

these 7 patches sync the LinuxTV.org DVB driver CVS completely with
your latest 2.6.0-test7. 

Major fixes:
- many dvb frontend related fixes:
  - unify the alps_bsrv2 frontend driver with the new ves1x93 frontend driver
  - add private data pointer to frontend drivers
  - misc fixes in other frontend drivers
- update dvb-net handling
- fix vbi capture for DVB-C cards with analog module installed

I also back-feeded the kernel janitor patches from 2.6.0-test7 to our
local CVS tree, so I don't wipe them out by accident in the future.

Please apply.

Thanks
Michael.

