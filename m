Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751732AbWEaQ6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbWEaQ6n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 12:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbWEaQ6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 12:58:43 -0400
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:18860 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751731AbWEaQ6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 12:58:42 -0400
To: linux-kernel@vger.kernel.org
Subject: PCI: Bus is hidden behind transparent bridge
From: Chris Ball <cjb@mrao.cam.ac.uk>
Date: Wed, 31 May 2006 17:58:24 +0100
Message-ID: <yd37j42m8r3.fsf@islay.ra.phy.cam.ac.uk>
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.4 (Social Property,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Noticed in dmesg:

   PCI: Bus #02 (-#05) is hidden behind transparent bridge #01 (-#02)
   (try 'pci=assign-busses')
   Please report the result to linux-kernel to fix this permanently

Booting with pci=assign-busses removes these two lines from the dmesg,
with no other noticeable change in behaviour.

Full dmesgs:
   http://www.inference.phy.cam.ac.uk/cjb/unity-dmesg
   http://www.inference.phy.cam.ac.uk/cjb/unity-dmesg-assign-busses

- Chris.
-- 
Chris Ball   <cjb@mrao.cam.ac.uk>    <http://blog.printf.net/>

