Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262718AbUKXOJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbUKXOJw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 09:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbUKXOHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 09:07:36 -0500
Received: from lucidpixels.com ([66.45.37.187]:53393 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S262726AbUKXNpx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:45:53 -0500
Date: Wed, 24 Nov 2004 08:39:09 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.9 4th SCSI Driver Compiliation Error w/GCC-3.4.2
Message-ID: <Pine.LNX.4.61.0411240838480.19627@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   CC [M]  drivers/scsi/qla2xxx/qla_os.o
drivers/scsi/qla2xxx/qla_os.c: In function `qla2x00_queuecommand':
drivers/scsi/qla2xxx/qla_os.c:315: sorry, unimplemented: inlining failed 
in call to 'qla2x00_callback': function not considered for inlining
drivers/scsi/qla2xxx/qla_os.c:269: sorry, unimplemented: called from here
drivers/scsi/qla2xxx/qla_os.c:315: sorry, unimplemented: inlining failed 
in call to 'qla2x00_callback': function not considered for inlining
drivers/scsi/qla2xxx/qla_os.c:269: sorry, unimplemented: called from here
make[3]: *** [drivers/scsi/qla2xxx/qla_os.o] Error 1
make[2]: *** [drivers/scsi/qla2xxx] Error 2
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

