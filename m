Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264437AbTLGQDA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 11:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbTLGQDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 11:03:00 -0500
Received: from sphere.barak.net.il ([212.150.48.98]:22696 "EHLO
	sphere.barak.net.il") by vger.kernel.org with ESMTP id S264437AbTLGQDA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 11:03:00 -0500
From: "Amir Hermelin" <amir@montilio.com>
To: <linux-kernel@vger.kernel.org>
Subject: Creating a page struct for HIGHMEM pages
Date: Sun, 7 Dec 2003 18:02:46 +0200
Organization: Montilio
Message-ID: <006c01c3bcdb$92290f50$1d01a8c0@CARTMAN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Suppose I want to create a page struct pointing to high memory (e.g. IO
mapped memory), that is, allocate the memory for the page struct myself and
fill in the values, what are the necessary flags/values (other than the
'virtual' field) I must be sure to set?  Does the page* need to be located
anywhere specific?  Does the pte field need to be set in anyway? The
question is relevant to kernel versions 2.4.20 and up.

Thanks,
Amir.


