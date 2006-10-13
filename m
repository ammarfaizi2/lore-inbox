Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWJMARJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWJMARJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 20:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWJMARJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 20:17:09 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:59881 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751357AbWJMARH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 20:17:07 -0400
Date: Thu, 12 Oct 2006 17:16:52 -0700
From: Paul Jackson <pj@sgi.com>
To: Greg KH <greg@kroah.com>
Cc: sekharan@us.ibm.com, matthltc@us.ibm.com, menage@google.com,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in
 configfs
Message-Id: <20061012171652.e157bc8d.pj@sgi.com>
In-Reply-To: <20061012235127.GA15767@kroah.com>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
	<20061010203511.GF7911@ca-server1.us.oracle.com>
	<6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com>
	<20061010215808.GK7911@ca-server1.us.oracle.com>
	<1160527799.1674.91.camel@localhost.localdomain>
	<20061011012851.GR7911@ca-server1.us.oracle.com>
	<20061011223927.GA29943@kroah.com>
	<1160609160.6389.80.camel@linuxchandra>
	<20061012235127.GA15767@kroah.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why are people so opposed to creating their own filesystems?

Well ... I'm not ;).  Though I will be eternally grateful to
Simon Derr for doing the heavy lifting needed to create the
cpuset filesystem.

For those of us whose brains don't hold so many details at once,
creating a new file system can seem a bit daunting.  And for those
of us not skilled in the art, it is more likely to end up being
300 lines of code, presenting several good provocations for a Hellwig
or a Viro to curse in the general direction of their monitors.

Instead of trying to hijack configfs to purposes ill suited for it,
I wonder if there isn't someway to lower the hurdles that us mere
mortals must leap to creating additional filesystems.

It shouldn't take that much lowering.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
