Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263115AbRE1STC>; Mon, 28 May 2001 14:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263116AbRE1SSx>; Mon, 28 May 2001 14:18:53 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:33721 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S263115AbRE1SSn>; Mon, 28 May 2001 14:18:43 -0400
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200105281816.TAA15469@mauve.demon.co.uk>
Subject: Loopback crypt.
To: linux-kernel@vger.kernel.org
Date: Mon, 28 May 2001 19:16:40 +0100 (BST)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any way to delete the key of an existing loopback encrypted
device, and have it block, until a key is reloaded?

Of course any cached pages would need deleted, and dirty ones flushed
first.

To enable things like deleting keys from memory, before suspend-to-disk,
or forcing users of devices to verify identitiy, on various events.

