Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264643AbUGMLTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264643AbUGMLTg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 07:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264910AbUGMLTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 07:19:35 -0400
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:35269 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S264643AbUGMLTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 07:19:30 -0400
Message-ID: <40F3BCD1.2090209@smallworld.cx>
Date: Tue, 13 Jul 2004 11:43:29 +0100
From: Ian Leonard <ian@smallworld.cx>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040519)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.27-rc3 sata ICH5R
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an motherboard with an Intel 82801EB. The documentation claims it 
has an Intel ICH5R sata interface.

With the previous kernel version I tried, it locked up when probing the 
disks on boot. 2.4.27-rc3 boots but gives many errors on /dev/hdg. These 
look something like:

hdg: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }

According to what I have read, this should be supported and should be 
using /dev/hd? rather than /dev/sd?. Is this correct?

TIA.

-- 
Ian Leonard

Please ignore spelling and punctuation - I did.
