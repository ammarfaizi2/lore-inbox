Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264254AbTLAWUg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 17:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264245AbTLAWUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 17:20:36 -0500
Received: from smtp2.wanadoo.fr ([193.252.22.29]:53743 "EHLO
	mwinf0204.wanadoo.fr") by vger.kernel.org with ESMTP
	id S264254AbTLAWUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 17:20:32 -0500
Subject: Re: Partitions on a loopback block device?
From: christophe varoqui <christophe.varoqui@free.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: devoteam
Message-Id: <1070317227.15260.44.camel@zezette>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-1mdk 
Date: Mon, 01 Dec 2003 23:20:27 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> A simple approach would be to use losetup with the offset function for
> every single parttion (while I'm not sure whether this works through 
> the CHS geometry).
> 
Or simply map the partitions with the device mapper.
Tools like partx/dmpartx may help.

regards,
cvaroqui

