Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVCWK0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVCWK0U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 05:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVCWK0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 05:26:19 -0500
Received: from hera.kernel.org ([209.128.68.125]:50124 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261492AbVCWK0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 05:26:17 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: lseek on /proc/kmsg
Date: Wed, 23 Mar 2005 10:25:50 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <d1rg7e$4h5$1@terminus.zytor.com>
References: <Pine.LNX.4.61.0503221320090.5551@chaos.analogic.com> <Pine.LNX.4.61.0503222215310.19826@yvahk01.tjqt.qr> <Pine.LNX.4.61.0503221633230.7421@chaos.analogic.com> <Pine.LNX.4.61.0503230811020.21578@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1111573550 4646 127.0.0.1 (23 Mar 2005 10:25:50 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 23 Mar 2005 10:25:50 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.61.0503230811020.21578@yvahk01.tjqt.qr>
By author:    Jan Engelhardt <jengelh@linux01.gwdg.de>
In newsgroup: linux.dev.kernel
> 
> Well, what does lseek(fd, >0, SEEK_END) do on normal files?
> 

Sets the file pointer beyond the end of the file (a write() there will
extend the file.)

	-hpa
