Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWDZMqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWDZMqe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 08:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWDZMqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 08:46:34 -0400
Received: from xproxy.gmail.com ([66.249.82.202]:46747 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932420AbWDZMqd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 08:46:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ncBUYU8PsLoRfhUYBMC/+Y4KIRbwnPqaSdGUAg3NYctvfwsZOevRwNsOOZRXjV3KsITG0zXNn9GfIMaU75n0qMkqtrSqtp+61bzfOWm7Fa/8HisUKnUOcXrAZ5LkJQPRQf+Qf5IF2NKwn5I69WrxvorqjOk1+3+rdlB7dHCh5eA=
Message-ID: <84d7d9cf0604260546s5d2fcfcfv32d3fe9ac5b3d639@mail.gmail.com>
Date: Wed, 26 Apr 2006 20:46:33 +0800
From: "Real Oneone" <realoneone@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: How to re-send out the packets captured by my hook function at NF_IP_PRE_ROUTING
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I plugged a callback function into netfilter at the hook point of
NF_IP_PRE_ROUTING, tring to capture all the packets, make
some changes to some of them, and invoke skb->dev->hard_start_xmit to
send them out directly. However, the kernel crashed before I could get
any printked information.

If you have any idea of how to send the received packets out, please tell me.

Thank you in advance.

Best regards,
Gu, Xinxing
