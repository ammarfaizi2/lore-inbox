Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbVJ0SF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbVJ0SF0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 14:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbVJ0SF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 14:05:26 -0400
Received: from hulk.vianw.pt ([195.22.31.43]:52674 "EHLO hulk.vianw.pt")
	by vger.kernel.org with ESMTP id S1751395AbVJ0SF0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 14:05:26 -0400
Message-ID: <436116DC.6030104@esoterica.pt>
Date: Thu, 27 Oct 2005 19:05:16 +0100
From: Paulo da Silva <psdasilva@esoterica.pt>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Learning ext2 fs
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am reading the ext2 fs code. One of my purposes
is to save the original data of a file to another file
just before it is changed by write/mmap/whatever.
Because of mmap (any other reasons?) I thought
of doing this at "ext2-writepage" or/and
"ext2-writepages".

Is this the right place?
Is there a lower level where I can read/write blocks
of data from/to hd instead of full pages?

How do I tell the really file data from other data?

I traced these functions but I only got
"ext2-writepages" to be called. "ext2-writepage"
was never called using the programs
I wrote to test this. When is "ext2-writepage" called?

Thanks for any help.
Any readings advice is also welcome.

