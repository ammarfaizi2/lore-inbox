Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVBAIUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVBAIUJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 03:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVBAIUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 03:20:09 -0500
Received: from web51102.mail.yahoo.com ([206.190.38.144]:61780 "HELO
	web51102.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261473AbVBAIUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 03:20:03 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=0ztlVb2nLnLzI5rI0oldFZLJQlXzzoYoEKNOa9AIoMsAtxz3bTstQSz5weG+mkNI1klC6rVz0lCRtIjePbh4cckbr58eigO91FMj2uz3wFYOA+jqWbrUY7Cy5Xa5FVnnPm2WB9+bJjFLfo8mScy0lDTvjUi5UAf20+kPT++iac0=  ;
Message-ID: <20050201082001.43454.qmail@web51102.mail.yahoo.com>
Date: Tue, 1 Feb 2005 00:20:01 -0800 (PST)
From: baswaraj kasture <kbaswaraj@yahoo.com>
Subject: Kernel 2.4.21 hangs up
To: Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       hugh@veritas.com, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
In-Reply-To: <41FF0281.6090903@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I compiled kernel 2.4.21 with intel compiler .
While booting it hangs-up . further i found that it
hangsup due to call to "calibrate_delay" routine in
"init/main.c". Also found that loop in the
callibrate_delay" routine goes infinite.When i comment
out the call to "callibrate_delay" routine, it works
fine.Even compiling "init/main.c" with "-O0" works
fine. I am using IA-64 (Intel Itanium 2 ) with EL3.0.

Any pointers will be great help.


Thanks,
-Baswaraj


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - 250MB free storage. Do more. Manage less. 
http://info.mail.yahoo.com/mail_250
