Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVBMCxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVBMCxw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 21:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVBMCxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 21:53:52 -0500
Received: from web14525.mail.yahoo.com ([216.136.224.54]:31611 "HELO
	web14525.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261236AbVBMCxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 21:53:45 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=gs4VOLCX0edYeo2MFylvYj756LW5iivNbVUkCQ/Q5x2CDH6g9otaJ9ZLMMz8U18ZcnTtwBOoSL429QQVSLnLw/MdkjV7qIqK7Mn4XExUAsfIlznsciSUjYCU/peCiNw23TFXKOlnmTXWU5sqmOHY/TY1ZJlcbOD5A5ZBTADK26M=  ;
Message-ID: <20050213025342.14876.qmail@web14525.mail.yahoo.com>
Date: Sat, 12 Feb 2005 18:53:42 -0800 (PST)
From: Daniel Dickman <didickman@yahoo.com>
Subject: [PATCH] correctly name the Shell sort
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As per http://www.nist.gov/dads/HTML/shellsort.html, this should be referred to
as a Shell sort. Shell-Metzner is a misnomer.

Signed-off-by: Daniel Dickman <didickman@yahoo.com>

--- linux-2.6.11-rc3-bk9/kernel/sys.c   2005-02-12 22:17:26.801294776 -0500
+++ linux/kernel/sys.c  2005-02-12 17:53:15.000000000 -0500
@@ -1192,7 +1192,7 @@
        return 0;
 }

-/* a simple shell-metzner sort */
+/* a simple Shell sort */
 static void groups_sort(struct group_info *group_info)
 {
        int base, max, stride;

