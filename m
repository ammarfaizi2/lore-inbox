Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267804AbUHYEnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267804AbUHYEnA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 00:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268084AbUHYEm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 00:42:59 -0400
Received: from user-0c99gfe.cable.mindspring.com ([24.148.193.238]:4224 "EHLO
	tuxq.com") by vger.kernel.org with ESMTP id S267804AbUHYEm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 00:42:58 -0400
Message-ID: <412C18D2.5080206@tuxq.com>
Date: Wed, 25 Aug 2004 00:42:58 -0400
From: "Steven E. Woolard" <tuxq@tuxq.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040809
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: ATAPI (Memory Leak?)
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After an attempt to burn an AUDIO CD using IDE (not scsi emulation)
the AUDIO CD played back on a regular cd-player only to have some very 
weird sounds.
Also, it might be a possible memory leak issue as well.
After doing this, I noticed my memory usage was at 730MB+ (of 1024MB)
Which is very far from normal (150MB)...
So I rebooted, and burned another audio-cd ... in hope of it was the way 
I obtained the WAV files (xmms diskwrite plugin)... I was wrong... 
Memory usage shot through the roof again... AUDIO CD was another coaster 
burn....

If this has been fixed in an rc or mm patch, let me know--I'll upgrade
As for now, I'm back on 2.6.7

As a side note: 2.6.7 burns Audio CD's just fine... memory usage also 
stays normal.
