Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbTEUNNz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 09:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbTEUNNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 09:13:55 -0400
Received: from goliath.sylaba.poznan.pl ([195.216.104.3]:61895 "EHLO
	goliath.sylaba.poznan.pl") by vger.kernel.org with ESMTP
	id S262114AbTEUNKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 09:10:40 -0400
Subject: Wrong DK_MAX_MAJOR in include/linux/kernel_stat.h in 2.4.20
From: Olaf =?iso-8859-2?Q?Fr=B1czyk?= <olaf@cbk.poznan.pl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 May 2003 15:25:28 +0200
Message-Id: <1053523529.22063.6.camel@venus>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by goliath.sylaba.poznan.pl id h4LDNdbb016152
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is set to 16. Why?
All IDE disks above hdb have major bigger than 16.
For SCSI it is not such pain as it is ok up to sdp.

So I get no stats for disks hdc and up in /proc/stat

Is it safe to just set DK_MAX_MAJOR 0xFF?

Please CC me.

Regards,

Olaf Frączyk








