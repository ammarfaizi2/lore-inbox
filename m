Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262620AbVAFQvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbVAFQvr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 11:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbVAFQvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 11:51:47 -0500
Received: from imag.imag.fr ([129.88.30.1]:43649 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S262620AbVAFQvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 11:51:45 -0500
Date: Thu, 6 Jan 2005 17:51:27 +0100
From: Alban Crequy <alban.crequy@apinc.org>
To: linux-kernel@vger.kernel.org
Cc: wmorgan-ruby-talkmasanjin.net@ensilinx1.imag.fr, roots@ensilinx1.imag.fr
Subject: status of poll/select in procfs
Message-ID: <20050106165127.GA14643@linux.ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-URL: http://alban.apinc.org/
Organization: ENSIMAG
User-Agent: Mutt/1.5.6+20040722i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Thu, 06 Jan 2005 17:51:29 +0100 (CET)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder what is the status of the poll/select syscalls with procfs:
should work, not tested or unwanted feature?

My tests say that some procfs' files work with select and some don't.

I've read the [1] thread.

This is a real-life issue for some interpretors since users threads may
be implemented with select in order to avoid one user thread blocking
others user threads. Ruby does that.

For example, some Ruby users report [2] [3] [4] that bugs are coming
from bug in procfs-select.

[1] http://www.issociate.de/board/post/28768/%5BPATCH_md_0_of_2%5D_Introduction.html
[2] http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/109668
[3] http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/110600
[4] (fr) http://linux.ensimag.fr/lists-archives/liste/2005-January/001396.html

-- 
Alban Crequy

PS: please CC: me as I am not subscribed to the list.




