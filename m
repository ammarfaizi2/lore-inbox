Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264083AbTDWPXP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 11:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbTDWPXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 11:23:15 -0400
Received: from franka.aracnet.com ([216.99.193.44]:9659 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264083AbTDWPXM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 11:23:12 -0400
Date: Wed, 23 Apr 2003 08:35:16 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 622] New: ALSA Choppy During Thing Like Window Changes 
Message-ID: <21270000.1051112116@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=622

           Summary: ALSA Choppy During Thing Like Window Changes
    Kernel Version: 2.5.68 and 2.5.67
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: pat@suwalski.net


Distribution: Gentoo
Hardware Environment: ALSA, 82801AA AC'97 Audio
Software Environment: Gnome
Problem Description:
When there is a short burst of high CPU usage, ALSA tends to skip for up to
a second. This has always worked fine with 2.4.x OSS.

Steps to reproduce:
Open anything that uses OSS-emulation with ALSA. Xine and XMMS are good
examples. Switch to windows that are pretty cpu intensive in drawing, say
Mozilla. The sound chops.

