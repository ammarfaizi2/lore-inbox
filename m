Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288511AbSAHWbH>; Tue, 8 Jan 2002 17:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288512AbSAHWar>; Tue, 8 Jan 2002 17:30:47 -0500
Received: from hera.cwi.nl ([192.16.191.8]:3230 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S288511AbSAHWao>;
	Tue, 8 Jan 2002 17:30:44 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 8 Jan 2002 22:30:41 GMT
Message-Id: <UTC200201082230.WAA283906.aeb@cwi.nl>
To: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: extern struct hd_struct *sd; ?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> does anyone know why is sd external?

Because it was used in both sd.c and sd_ioctl.c.

What is sd_ioctl.c? See any kernel older than 2.3.27.
Today there is no need for this external declaration, I think.

Andries
