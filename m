Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVF0PVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVF0PVw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 11:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbVF0PLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 11:11:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:9651 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261292AbVF0OXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 10:23:42 -0400
Date: Mon, 27 Jun 2005 16:23:28 +0200
From: Jan Kara <jack@suse.cz>
To: akpm@osdl.org
Cc: sct@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Checkpoint lists split
Message-ID: <20050627142328.GM20512@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello Andrew!

  I've noticed that the patch splitting transaction's t_checkpoint_list
into two lists (one for buffers to-be-submitted and one for already
submitted buffers) is not in -mm kernels. Is there any reason why you've
dropped it? If you just missed the version that fixed the bug or some
similar mistake happened then please put the patch into -mm (it's
attached and applies fine against 2.6.12-mm2). Any comments are welcome.

							Thanks
								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
