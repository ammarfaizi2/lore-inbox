Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbVDFGDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbVDFGDZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 02:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVDFGDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 02:03:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46542 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262115AbVDFGDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 02:03:22 -0400
Date: Wed, 6 Apr 2005 02:03:18 -0400
From: Dave Jones <davej@redhat.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: nm256 oss build failure
Message-ID: <20050406060318.GD15168@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

static declaration follows non static blah blah..

Signed-off-by: Dave Jones <davej@redhat.com>

--- 2.6.12rc2mm1/sound/oss/nm256_audio.c~	2005-04-06 02:00:08.000000000 -0400
+++ 2.6.12rc2mm1/sound/oss/nm256_audio.c	2005-04-06 02:00:39.000000000 -0400
@@ -28,10 +28,12 @@
 #include <linux/delay.h>
 #include <linux/spinlock.h>
 #include "sound_config.h"
+
+static int nm256_debug;
+
 #include "nm256.h"
 #include "nm256_coeff.h"
 
-static int nm256_debug;
 static int force_load;
 
 /* 
