Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbTD2AAP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 20:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbTD2AAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 20:00:11 -0400
Received: from bunyip.cc.uq.edu.au ([130.102.2.1]:43279 "EHLO
	bunyip.cc.uq.edu.au") by vger.kernel.org with ESMTP id S261417AbTD2AAI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 20:00:08 -0400
Message-ID: <3EADC3D6.7090203@torque.net>
Date: Tue, 29 Apr 2003 10:14:14 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: dgilbert@interlog.com, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi_mid_low_api.txt
References: <UTC200304271111.h3RBB6M14317.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> The specification says that slave_configure() has to call
> scsi_adjust_queue_depth(). This is false, and moreover
> does not always happen in the current tree.
> (I was interested since I plan to add a slave_configure()
> that will not call scsi_adjust_queue_depth().)
> 
> So, the patch below adapts scsi_mid_low_api.txt a little.


Andries,
I applied your patch to my version which is found at:
http://www.torque.net/scsi/scsi_mid_low_api.txt.gz

It describes some changes from Mike Anderson
and others that are not yet in the kernel (e.g. a full
implementation of scsi_set_device_offline() ). That is
why it hasn't been presented as a patch yet.

Thanks for the feedback.

Doug Gilbert


