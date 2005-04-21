Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVDUWVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVDUWVf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 18:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVDUWVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 18:21:35 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:47964 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261409AbVDUWVb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 18:21:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hiVAMTsRQB1mCRrDUFW0aP16B51v01IGLDxy7KSl71R+jswc6a6qi+d3hlwRwfJ1dRODNB+WjabEYPzam0iyheYLlRTQivabTs1RoaiVZE6ivk5G3xKbf/IrtvhrnARR2/gwtfa+FHQYAm7NyC2FstH7wwSXbGkCBnEPJRlTyJE=
Message-ID: <7f45d939050421152171400450@mail.gmail.com>
Date: Thu, 21 Apr 2005 15:21:30 -0700
From: Shaun Jackman <sjackman@gmail.com>
Reply-To: Shaun Jackman <sjackman@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: netdev watchdog
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upon booting my system, the boot fails and the following message is
displayed repeatedly:

NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status eb01.
diagnostics: net 0cfa media 88c0 dma 0000003a fifo 0000
eth0: Interrupt posted but not delivered -- IRQ blocked by another device?
Flags; bus-master 1, dirty 65(1) current 65(1)
Transmit list 00000000 vs d0c782a0
0: @d0c78200 length 8000002e status 8001002e
...

I also see the same message for eth2. I'd been happily booting this
2.6.8.1 kernel for months without trouble. I don't know where this is
coming from. The drivers for my three NICs are forcedeth, 3c59x, and
8139too. I'd be happy to give more information to help.

Please cc me in your reply. Cheers,
Shaun
