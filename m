Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263758AbTLUSno (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 13:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTLUSno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 13:43:44 -0500
Received: from linux-bt.org ([217.160.111.169]:36010 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S263758AbTLUSnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 13:43:42 -0500
Subject: Bluetooth bus type for input subsystem
From: Marcel Holtmann <marcel@holtmann.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Vojtech Pavlik <vojtech@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1072032169.2684.86.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 21 Dec 2003 19:42:49 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

the file include/linux/input.h contains a various number of bus id's
where a input device can be on. But there is nothing for a Bluetooth
mouse or keyboard. So I want to add

	#define BUS_BLUETOOTH 0x05

Regards

Marcel


Please do a

        bk pull http://linux-mh.bkbits.net/input-2.4

This will update the following files:

 include/linux/input.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

through these ChangeSets:

<marcel@holtmann.org> (03/12/21 1.1305)
   [PATCH] Add Bluetooth to the bus types of the input subsystem
   
   This patch adds the Bluetooth bus type to the list of other bus types
   of the input subsystem.



