Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVEFSwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVEFSwY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 14:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVEFSwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 14:52:24 -0400
Received: from agmk.net ([217.73.17.121]:25096 "EHLO mail.agmk.net")
	by vger.kernel.org with ESMTP id S261257AbVEFSwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 14:52:20 -0400
From: Pawel Sikora <pluto@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: modpost warning: drivers/ieee1394/* ids 64 bad size (each on 28)
Date: Fri, 6 May 2005 20:52:12 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505062052.13152.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

During 2.6.11.8 crossbuild (build:x86, target:amd64) I get:

(...)
  Building modules, stage 2.
  MODPOST
*** Warning: drivers/ieee1394/dv1394 ids 64 bad size (each on 28)
*** Warning: drivers/ieee1394/eth1394 ids 64 bad size (each on 28)
*** Warning: drivers/ieee1394/raw1394 ids 96 bad size (each on 28)
*** Warning: drivers/ieee1394/sbp2 ids 64 bad size (each on 28)
*** Warning: drivers/ieee1394/video1394 ids 64 bad size (each on 28)
(...)

I'm seeing such a warnings for the first time.
Do I have a broken crosstoolchain?

# gcc-4.0.0 + fixes for PR20973,PR21173
# binutils-2.16.90.0.2

-- 
The only thing necessary for the triumph of evil
  is for good men to do nothing.
                                           - Edmund Burke
