Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbSKKWgc>; Mon, 11 Nov 2002 17:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261530AbSKKWgc>; Mon, 11 Nov 2002 17:36:32 -0500
Received: from smtp.terra.es ([213.4.129.129]:11433 "EHLO tsmtp4.mail.isp")
	by vger.kernel.org with ESMTP id <S261527AbSKKWgb>;
	Mon, 11 Nov 2002 17:36:31 -0500
Message-ID: <00df01c289d3$52969420$6e9afea9@anabel>
From: =?iso-8859-1?Q?David_San=E1n_Baena?= <davidsanan@teleline.es>
To: <linux-kernel@vger.kernel.org>
Subject: how to access user space memory from kernel.
Date: Mon, 11 Nov 2002 23:40:19 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. I need to access to user space memory from a kernel module. This module
is not a driver, so I would like how can i write and read from/to a variable
in a user application from my kernel module?
At first I thought I could do that with shared memory (shmget, shmat...),
but in that is not possible in a kernel module. So I have thought to do it
with copy_from_user and copy_to_user, but i don't know how to do it exactly,
basically how to know where to write or read in the user var...
Any suggestion???
Thanks in advance

