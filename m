Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279262AbRJWFyd>; Tue, 23 Oct 2001 01:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279263AbRJWFyY>; Tue, 23 Oct 2001 01:54:24 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:40677 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S279262AbRJWFyG>;
	Tue, 23 Oct 2001 01:54:06 -0400
To: <linux-kernel@vger.kernel.org>
Subject: (WAN) network device status
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 22 Oct 2001 16:06:57 +0200
Message-ID: <m3itd7rcou.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I remember a discussion about net_dev->flags and carrier loss etc
detection. Did the things change? I mean, do we currently have a way
for network device driver to report (to the rest of kernel, to the
userland) that the link is down? It would include DCD (carrier) loss,
Ethernet link down, IrDA/USB disconnects etc.

I think the kernel should deactivate respective routing table entries
as well when a link goes down.
-- 
Krzysztof Halasa
Network Administrator
