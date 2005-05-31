Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVEaTfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVEaTfk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 15:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVEaTfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 15:35:40 -0400
Received: from transfire.txc.com ([208.5.237.254]:25768 "EHLO
	mailproxy2.txc.com") by vger.kernel.org with ESMTP id S261338AbVEaTff
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 15:35:35 -0400
Date: Tue, 31 May 2005 15:35:33 -0400
From: Igor Schein <igor@txc.com>
To: linux-kernel@vger.kernel.org
Subject: 64bit filesize limit on a 32bit linux
Message-ID: <20050531193533.GO1337@txc.com>
Reply-To: igor@txc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-TXC-MailScanner-Information: Please contact SysAdmin group (help@txc.com) for more information
X-TXC-MailScanner: Found to be clean
X-MailScanner-From: igor@txc.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

# ulimit -f `echo 2^22-1|bc`;ulimit -f
4194303
# ulimit -f `echo 2^22|bc`;ulimit -f
unlimited
# uname -r
2.6.11-1.1290_FC4

I need to limit users to 5GB per file instead of 4GB.  Do I need any
kernel patches or can it somehow be done in user space?

Thanks

Igor
