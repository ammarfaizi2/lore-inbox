Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVA0U6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVA0U6Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 15:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVA0UzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 15:55:22 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:62948 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261187AbVA0Uwi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:52:38 -0500
Date: Thu, 27 Jan 2005 21:52:51 +0100
From: martin.weissenborn@t-online.de (Martin =?iso-8859-1?Q?Wei=DFenborn?=)
To: linux-kernel@vger.kernel.org
Subject: 2.6.9: hd?: dma_intr: error=0xd7 --> ide: failed opcode was: unknown
Message-ID: <20050127205251.GA1024@deep.skynet.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux deep 2.6.9 
X-ID: XH5FxsZX8eOoCA2HcZsibLewB-rXKHtUhIAvWb3tDz9gTvQakFj-YS
X-TOI-MSGID: aa7cf7f6-8100-4d27-8637-b32fec850250
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

running stock 2.6.9 with IDE UDMA(33) disk drive, kernel wrote:


hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }

hda: dma_intr: error=0xd7 { DriveStatusError BadCRC UncorrectableError
SectorIdNotFound TrackZeroNotFound AddrMarkNotFound }, CHS=1157/0/130,
sector=30901687

ide: failed opcode was: unknown


two times in a second to syslogd, simultaneously seemingly all I/O
freezed with hdd status LED lid. After approximately two minutes of
waiting I rebooted with fsck correcting few i_blocks, i_sizes errors.
No further incidents followed.


The questions I were not able to find answers myself for are:

- Could that error be related to bad RAM DIMMs?
- Could it be a direct failure of my hdd?
- Should I be aware of dying hardware?

A CC'ed reply would be really great. ^.^

Thanks in advance,
Martin Weiﬂenborn 
