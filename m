Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752000AbWJMXiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbWJMXiK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 19:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbWJMXiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 19:38:09 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:63629 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752000AbWJMXiH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 19:38:07 -0400
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in
	configfs
From: Matt Helsley <matthltc@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Greg KH <greg@kroah.com>, sekharan@us.ibm.com, menage@google.com,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
In-Reply-To: <20061012171652.e157bc8d.pj@sgi.com>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
	 <20061010203511.GF7911@ca-server1.us.oracle.com>
	 <6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com>
	 <20061010215808.GK7911@ca-server1.us.oracle.com>
	 <1160527799.1674.91.camel@localhost.localdomain>
	 <20061011012851.GR7911@ca-server1.us.oracle.com>
	 <20061011223927.GA29943@kroah.com> <1160609160.6389.80.camel@linuxchandra>
	 <20061012235127.GA15767@kroah.com>  <20061012171652.e157bc8d.pj@sgi.com>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Fri, 13 Oct 2006 16:38:04 -0700
Message-Id: <1160782684.18766.550.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 17:16 -0700, Paul Jackson wrote:

<snip>

> For those of us whose brains don't hold so many details at once,
> creating a new file system can seem a bit daunting.  And for those
> of us not skilled in the art, it is more likely to end up being
> 300 lines of code, presenting several good provocations for a Hellwig
> or a Viro to curse in the general direction of their monitors.

Definitely.

> Instead of trying to hijack configfs to purposes ill suited for it,
> I wonder if there isn't someway to lower the hurdles that us mere
> mortals must leap to creating additional filesystems.

	Again, I don't think using configfs to define groups of tasks is
ill-suited to the purpose of configfs. I think we're confusing the
limitations of the implementation with the purpose for having configfs
in addition to sysfs.

Cheers,
	-Matt Helsley

