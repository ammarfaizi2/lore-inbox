Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVHAVyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVHAVyB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVHAVwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:52:24 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:2309 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261285AbVHAVuS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:50:18 -0400
Message-ID: <42EE9A29.7070801@deathstar.prodigy.com>
Date: Mon, 01 Aug 2005 17:54:49 -0400
From: Bill Davidsen <davidsen@deathstar.prodigy.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Finding out which SCSI drive is mapped to which device
References: <1122408090.30584e6dd23e19ddaa14a273d0f13357@teranews> <slrndeff9b.c2q.lgb@aztec.eclipse> <1122574146.ebb81542308f9689a1316bbe86b8e41c@teranews>
In-Reply-To: <1122574146.ebb81542308f9689a1316bbe86b8e41c@teranews>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Erasmus wrote:
> On Wed, 27 Jul 2005 16:58:20 -0000, Chiefy <lgb@non.existent.invalid>
> wrote:
> 
> 
>>26 Jul 2005 20:04 UTC, Anton Erasmus typed:
>>
>>>How can I find out which SCSI ID is mapped to which device ?
>>
>>Have a look at sg3_utils http://sg.torque.net/sg/index.html
> 
> 
> Thanks,
> 
> These utilities seem to be for SCSI devices which are not disks, tapes
> or CD-ROMs. All my SCSI devices are disks. I only need to find out
> which SCSI ID maps to sda, and which ID to sdb etc.

For human information "cat /proc/scsi/scsi" might do

-- 
bill davidsen
   SBC/Prodigy Yorktown Heights NY data center
   http://newsgroups.news.prodigy.com
