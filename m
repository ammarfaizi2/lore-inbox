Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263692AbTDNVPw (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263767AbTDNVPw (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:15:52 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:13191 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263692AbTDNVPv (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 17:15:51 -0400
Subject: 2.5.67-mm3: CONFIG_VIDEO_SELECT
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1050355641.9160.34.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 14 Apr 2003 23:27:22 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't compile 2.5.67-mm3 successfully if CONFIG_VIDEO_SELECT is not
set in ".config". The compilation fails at setup.o, complaining that
"store_edid" (defined in video.S) cannot be resolved.

I had to set CONFIG_VIDEO_SELECT in order to compile.

-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

