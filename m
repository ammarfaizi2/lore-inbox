Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVAEApa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVAEApa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 19:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVAEAcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 19:32:16 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:37010 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262105AbVAEAbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 19:31:24 -0500
Message-ID: <41DB35B8.1090803@sgi.com>
Date: Tue, 04 Jan 2005 18:32:56 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Hirokazu Takahashi <taka@valinux.co.jp>, Dave Hansen <haveblue@us.ibm.com>,
       Marcello Tosatti <marcelo.tosatti@cyclades.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Subject: page migration patchset
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Dave Hansen and I have reordered the memory hotplug patchset so that the page 
migration patches occur first.  This allows us to create a standalone page
migration patchset (on top of which the rest of the memory hotplug patches
apply).  A snapshot of these patches is available at:

http://sr71.net/patches/2.6.10/2.6.10-mm1-mhp-test7/

A number of us are interested in using the page migration patchset by itself:

(1)  Myself, for a manual page migration project I am working on.  (This
      is for migrating jobs from one set of nodes to another under batch
      scheduler control).
(2)  Marcello, for his memory defragmentation work.
(3)  Of course, the memory hotplug project itself.

(there are probably other "users" that I have not enumerated here).

Unfortunately, none of these "users" of the page migration patchset are ready
to be merged into -mm yet.

The question at the moment is, "Would you be interesting in merging the
page migration patchset now, or should we wait until one or more of (1) to
(3) above is also ready for merging?"

(Historically, lkml has waited for a user of new functionality before merging
that functionality, so I expect that to be your answer;  in that case, please
consider this note to be an preliminary notice that we will be submitting
such patches for merging in the next month or so.  :-) )
-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------
