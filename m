Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUCDCw1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 21:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbUCDCw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 21:52:27 -0500
Received: from cheltenham.cs.arizona.edu ([192.12.69.60]:23059 "EHLO
	cheltenham.cs.arizona.edu") by vger.kernel.org with ESMTP
	id S261426AbUCDCwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 21:52:16 -0500
Date: Wed, 3 Mar 2004 19:52:15 -0700 (MST)
From: Sharath Kodi Udupa <sku@CS.Arizona.EDU>
To: linux-kernel@vger.kernel.org
Subject: cryptoAPI woes
Message-ID: <Pine.GSO.4.58.0403031949320.16225@lectura.CS.Arizona.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using the cryptoAPI digest function to calculate the SHA1 digest for
executable pages,i.e. I have added the function to compute the digest in
the filemap_nopage method. But the page SHA1 I compute from the file
doesnt match with the one computed in the kernel. Does the page contents
get changed when it is loaded into memory from an executable file (ie
belongs to the load segment of the ELF file)

regards,
Sharath K Udupa
Graduate Student,
Dept. of Computer Science,
University of Arizona.
sku@cs.arizona.edu
http://www.cs.arizona.edu/~sku


"Sometimes I think the surest sign that intelligent life exists
elsewhere in the universe is that none of it has tried to contact us."
--Calvin, The Indispensable Calvin and Hobbes


