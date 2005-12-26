Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbVLZGFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbVLZGFE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 01:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbVLZGFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 01:05:04 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:19586 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751028AbVLZGFD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 01:05:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aJCcNwg2sWEQcaPgeSk4QhGXKWBfvOJPoYGC9pSBSFQVxKTFmhMEJUVhljLdc05TQ1WAm6uHGS7IrFlKmjT+fZwMoti+bRl21rVVB5EvsopZkrUTdQrri5Nwlc8KAbGnOrFxeiVh2fcS6qEEaZk6JwHQMBAjSPU4ML6eBe3hRi4=
Message-ID: <7a37e95e0512252205t68c6b6f6sfeedf3a75880fda9@mail.gmail.com>
Date: Mon, 26 Dec 2005 11:35:00 +0530
From: Deven Balani <devenbalani@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Ping-Pong Compatible DMA buffer chaining
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All!

I am developing a SATA Driver which is libata-complaint for ARM
platform for linux-2.4 kernels.

But I am facing these issues:
1) The SATA Host Controller supports a DMA Logic which has Ping Pong Buffers.
How Can I allocate a linear contiguous buffer and give it to the
Buffer Descriptors of the Host Controller. I believe consistent alloc
would help me in this regard. But How could I do a chaining of Buffers
in a Ping Pong Scenario which has Buffer Descriptors.
2) The libata is using Scatter-Gather List to send Device Identify
Command. Is it necessary to have a Scatter-Gather List for non-PCI ARM
platforms. Can I bypass this mechanism.

Thanks,
Deven
