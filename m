Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbVAJECD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVAJECD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 23:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVAJECD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 23:02:03 -0500
Received: from lon-del-03.spheriq.net ([195.46.50.99]:43683 "EHLO
	lon-del-03.spheriq.net") by vger.kernel.org with ESMTP
	id S262063AbVAJEBz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 23:01:55 -0500
From: Alex LIU <alex.liu@st.com>
To: <linux-kernel@vger.kernel.org>
Subject: The purpose of PT_TRACESYSGOOD
Date: Mon, 10 Jan 2005 11:58:56 +0800
Message-ID: <005c01c4f6c8$b4d3fba0$ac655e0a@sha.st.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-O-Virus-Status: No
X-O-URL-Status: Not Scanned
X-O-CSpam-Status: Not Scanned
X-O-Spam-Status: Not scanned
X-O-Image-Status: Not Scanned
X-O-Att-Status: No
X-SpheriQ-Ver: 1.8.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

What's the effect of PT_TRACESYSGOOD flag? I found it's used only set in ptrace_setoptions,which is called in the function ptrace_request. And the PT_TRACESYSGOOD flag will be requested in do_syscall_trace. What's the purpose of that flag? Thanks! 

Alex

