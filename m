Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWAZNKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWAZNKq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 08:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWAZNKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 08:10:46 -0500
Received: from uproxy.gmail.com ([66.249.92.207]:2960 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751345AbWAZNKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 08:10:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=tAXncgfjV4G+KdH1gZL19kF15L8XrA9l++T9JEzJ7jNzO+d0pb69sucUhd7N49uWQRHG5ScrxvYwwf0zE0UOxEqCeZv2X63be+08ocx4mTmnjQRom4egb7+44gNE5cL2qKqHfIJDlj94DHp72g6YU/3HN3r57CN7rrjcKQs5zV8=
Date: Thu, 26 Jan 2006 16:28:30 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Domen Puncer <domen@coderock.org>, linux-kernel@vger.kernel.org,
       jffs-dev@axis.com
Subject: [PATCH] Remove fs/jffs2/histo.h
Message-ID: <20060126132830.GD9288@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Domen Puncer <domen@coderock.org>

Remove nowhere referenced file (egrep "histo\." didn't find anything).

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/jffs2/histo.h |    3 ---
 1 file changed, 3 deletions(-)

--- a/fs/jffs2/histo.h
+++ b/fs/jffs2/histo.h
@@ -1,3 +0,0 @@
-/* This file provides the bit-probabilities for the input file */
-#define BIT_DIVIDER 629
-static int bits[9] = { 179,167,183,165,159,198,178,119,}; /* ia32 .so files */

