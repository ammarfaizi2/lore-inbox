Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319227AbSH2Ozi>; Thu, 29 Aug 2002 10:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319228AbSH2Ozi>; Thu, 29 Aug 2002 10:55:38 -0400
Received: from uni-sb.de ([134.96.252.33]:20732 "EHLO uni-sb.de")
	by vger.kernel.org with ESMTP id <S319227AbSH2Ozh>;
	Thu, 29 Aug 2002 10:55:37 -0400
Date: Thu, 29 Aug 2002 16:59:54 +0200
Message-Id: <200208291459.g7TExsPT016952@pixel.cs.uni-sb.de>
From: Georg Demme <gdemme@graphics.cs.uni-sb.de>
To: Alexander.Riesen@synopsys.com
CC: linux-kernel@vger.kernel.org
In-reply-to: <20020828124443.GD16092@riesen-pc.gr05.synopsys.com> (message
	from Alex Riesen on Wed, 28 Aug 2002 14:44:43 +0200)
Subject: Re: Server Hangups
References: <200208281049.g7SAnFX7004638@pixel.cs.uni-sb.de> <20020828111240.GC16092@riesen-pc.gr05.synopsys.com> <200208281235.g7SCZZ9H001715@pixel.cs.uni-sb.de> <20020828124443.GD16092@riesen-pc.gr05.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

today we tried a new minimal kernel, without nvidia, sound, ... 
It didn't work. Still hangups.

The messages

> Aug 27 19:51:03 graphics kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> Aug 27 19:51:03 graphics kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
> Aug 27 19:51:02 graphics kernel: 3w-xxxx: scsi2: Unknown scsi opcode: 0x1a
> Aug 27 19:51:02 graphics kernel: 3w-xxxx: scsi2: Unknown scsi opcode: 0x4d

are all caused by smartctl calls done by system monitor scripts.

Georg

-- 
______________________________________________________________
sent by gdemme@cs.uni-sb.de                    - Georg Demme - 
http://graphics.cs.uni-sb.de/~gdemme/    Tel: +49 681/302-3834
Universität des Saarlandes       -      Gebäude 36.1, Raum E15
