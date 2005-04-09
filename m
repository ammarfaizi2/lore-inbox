Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVDIJ5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVDIJ5u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 05:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVDIJ5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 05:57:50 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:16292 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S261323AbVDIJ5s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 05:57:48 -0400
Subject: Re: HELP:porting linux PXA audio driver to RTLinux(RTLinux core driver)
From: "nitin ahuja" <nitin2ahuja@myrealbox.com>
To: nobin_matthew@yahoo.com
CC: kernelnewbies@nl.linux.org, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Date: Sat, 09 Apr 2005 03:57:28 -0600
X-Mailer: NetMail ModWeb Module
MIME-Version: 1.0
Message-ID: <1113040648.8c11a3fcnitin2ahuja@myrealbox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You cannot allocate memory in real time threads RTLinux's threads. You have to do it in the init_module function and pass the meory pointer to threads as parameter. 

Can you tell exactly what problem are you facing?

niTin

