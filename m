Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbTIAGYH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 02:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbTIAGYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 02:24:07 -0400
Received: from 205-158-62-67.outblaze.com ([205.158.62.67]:25023 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S262613AbTIAGYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 02:24:05 -0400
Message-ID: <20030901062643.14448.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Gordon Stanton" <coder101@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Mon, 01 Sep 2003 14:26:43 +0800
Subject: [RFC] must fix generic_serial .c
X-Originating-Ip: 203.2.128.124
X-Originating-Server: ws5-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  While trying to get most drivers in the kernel to compile, I had to skip a lot of the older ones that use cli() and sti() since deep knowledge is needed to fix those. Because of this I am asking that someone would please fix generic_serial.c in drivers/char and document in a HOWTO on the steps they took and the reasons behind it. This would help more people to be able to understand and fix a lot of the other drivers with the cli/sti problem. Even if the it wasn't generic_serial.c but one of the other serial drivers with the same problem, it still would be very instructive and help other to improve the kernel quicker. 

Gordon
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
