Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265431AbUBAR75 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 12:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265433AbUBAR75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 12:59:57 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:1725 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S265431AbUBAR7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 12:59:55 -0500
Message-ID: <401D3E97.5080902@samwel.tk>
Date: Sun, 01 Feb 2004 18:59:51 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: reiser@namesys.com
Subject: Reiserfs flags question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I was looking at fs/reiserfs/inode.c, and I noticed that the functions 
sd_attrs_to_i_attrs and i_attrs_to_sd_attrs are not exact inverses: 
i_attrs_to_sd_attrs doesn't convert the S_APPEND flag to 
REISERFS_APPEND_FL, but sd_attrs_to_i_attrs does convert 
REISERFS_APPEND_FL to S_APPEND. I was wondering, is this intentional?

--Bart
