Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbTFWPkh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 11:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264276AbTFWPkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 11:40:37 -0400
Received: from [62.75.136.201] ([62.75.136.201]:29331 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S264272AbTFWPkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 11:40:37 -0400
Message-ID: <3EF722C4.1060004@g-house.de>
Date: Mon, 23 Jun 2003 17:54:44 +0200
From: Christian Kujau <evil@g-house.de>
Reply-To: evil@g-house.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4b) Gecko/20030507
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: lord@sgi.com
Subject: module xfs: Relocation overflow vs section 9
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i can't use XFS in 2.5.72 on linux Alpha, inserting the module gives:

kernel: module xfs: Relocation overflow vs section 9
modprobe: FATAL: Error inserting xfs 
(/lib/modules/2.5.72/kernel/fs/xfs/xfs.ko): Invalid module format

in the log.

