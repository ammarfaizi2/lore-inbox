Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265940AbUBJPqE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 10:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUBJPqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 10:46:03 -0500
Received: from topaz-57.mcs.anl.gov ([140.221.57.209]:55941 "EHLO
	topaz.mcs.anl.gov") by vger.kernel.org with ESMTP id S265940AbUBJPqB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 10:46:01 -0500
To: linux-kernel@vger.kernel.org
Subject: strange alsa sound distortion w/2.6.3rc1
From: Narayan Desai <desai@mcs.anl.gov>
Date: Tue, 10 Feb 2004 09:45:57 -0600
Message-ID: <87hdxzc4zu.fsf@topaz.mcs.anl.gov>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Audio on my thinkpad (snd-cs46xx) gets dramatically slowed down when I
use my wireless card. It is a pcmcia orinoco card. It appears that the
yenta socket driver uses the same interrupt as the sound card. Does
this sound familiar to anyone? This has happened for a little while,
but this started sometime in the last few months...

I just checked, and this doesn't happen with the old OSS drivers
(under the same kernel) Does anyone have any ideas?
 -nld
