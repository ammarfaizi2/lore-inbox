Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965056AbVIAGYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbVIAGYZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 02:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbVIAGYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 02:24:25 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:53255 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S965056AbVIAGYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 02:24:25 -0400
From: Meelis Roos <mroos@linux.ee>
To: Nigel Cunningham <ncunningham@cyclades.com>, linux-kernel@vger.kernel.org,
       "Eric W.Biederman" <ebiederm@xmission.com>,
       Len Brown <len.brown@intel.com>
Subject: reboot vs poweroff (was: Linux 2.6.13)
In-Reply-To: <52oe7gomak.fsf@cisco.com>
User-Agent: tin/1.7.10-20050815 ("Grimsay") (UNIX) (Linux/2.6.13 (i686))
Message-Id: <20050901062406.EBA5613D5B@rhn.tartu-labor>
Date: Thu,  1 Sep 2005 09:24:06 +0300 (EEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RD> Well, there aren't many differences between 2.6.13-rc7 and 2.6.13.  If
RD> I had to guess, I would bet the commit below is what broke you.  I'm
RD> including a patch that reverts it at the end of this email

Nigel, have you tried reverting the patch Roland pointed out? It
probably helps you.

I am also interested in this but in another way - the fix fixed reboot
for me (and at least one more person) and just plain reverting it will
break it again. Some better fix will probably be needed.

-- 
Meelis Roos
