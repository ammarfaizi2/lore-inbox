Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267889AbUHPTMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267889AbUHPTMw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 15:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267903AbUHPTMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 15:12:51 -0400
Received: from staging.airflowsciences.com ([66.178.220.191]:15759 "EHLO
	staging.airflowsciences.com") by vger.kernel.org with ESMTP
	id S267889AbUHPTMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 15:12:36 -0400
Message-ID: <41210601.6090202@airflowsciences.com>
Date: Mon, 16 Aug 2004 15:07:45 -0400
From: "Robert K. Nelson" <rnelson@airflowsciences.com>
Reply-To: rnelson@airflowsciences.com
Organization: Airflow Sciences Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SCSI Bus Parity errors with all Kernels after 2.4.26
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a machine configuration with runs fine under a variety of older 
kernels and fails under a variety of newer ones.  I was hoping someone 
could dircet me to a person who would like to look further into this.

SCSI Configuration -
Symbios Logic SYM8951U
    Quantum Viking II 4.5GB
    IBM DNES-30917OW 9.0GB
ASUS SC875 Symbios Logic
    IOMEGA ZOP 100
    Pioneer CD-ROM DR U065

Works under:
    Various RedHat 4, 5, 6 and 7 systems
    RedHat 8.0 running 2.4.18
    RedHat 8.0 running 2.4.20
    Debian 2.2 running 2.4.5

Fails under
    Redhat 9.0 running 2.4.26
    Suse 9.1 running 2.6.5
    Debian 3.0

It fails with a SCSI bus error, either crashing entirely or refusing to 
mount one or more file systems on the second disk.the second disk. 
Looks like something has changed, and not for the better for this 
configuration.

More information avaiable on request.  I am interested in helping to 
trace this down.

Please cc: my personal e-mail in response, since I do not subscribe.

Robert K. Nelson

