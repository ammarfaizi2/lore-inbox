Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbUFVI7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUFVI7X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 04:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUFVI7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 04:59:22 -0400
Received: from postin.uv.es ([147.156.1.90]:51648 "EHLO postin.uv.es")
	by vger.kernel.org with ESMTP id S261604AbUFVI7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 04:59:13 -0400
Date: Tue, 22 Jun 2004 10:59:09 +0200
From: uaca@alumni.uv.es
To: linux-kernel@vger.kernel.org
Subject: capabilities, cap_set_cap and setuid()
Message-ID: <20040622085908.GA13906@pusa.informat.uv.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I didn't find an answer about enabling CAP_SETPCAP

Why is deemed a security risk? 

Maybe the question seems silly but, where is the risk, a root user
can setuid /bin/sh and maked things still more fun... it sounds brain dead.

Another question... why is not allowed to do the following:

uid = 0 program enables enables only one capability (in all sets) and if it
changes to another uid (by calling setuid) the program losses the
capability.

Any comment would be greatly appreciated

Thanks in advance

	Ulisses

                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

