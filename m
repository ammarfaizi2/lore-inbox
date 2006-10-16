Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422855AbWJPW3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422855AbWJPW3H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 18:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422881AbWJPW3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 18:29:07 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:24779 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422855AbWJPW3F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 18:29:05 -0400
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in
	configfs
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, menage@google.com,
       matthltc@us.ibm.com, ckrm-tech@lists.sourceforge.net
In-Reply-To: <20061016133256.e09e76ac.pj@sgi.com>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
	 <20061010203511.GF7911@ca-server1.us.oracle.com>
	 <6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com>
	 <20061010215808.GK7911@ca-server1.us.oracle.com>
	 <1160527799.1674.91.camel@localhost.localdomain>
	 <20061011012851.GR7911@ca-server1.us.oracle.com>
	 <20061011223927.GA29943@kroah.com> <1160609160.6389.80.camel@linuxchandra>
	 <20061012235127.GA15767@kroah.com> <1161025825.6389.119.camel@linuxchandra>
	 <20061016133256.e09e76ac.pj@sgi.com>
Content-Type: text/plain
Organization: IBM
Date: Mon, 16 Oct 2006 15:29:01 -0700
Message-Id: <1161037741.5057.2.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-16 at 13:32 -0700, Paul Jackson wrote:

<snip>

> Chandra - I haven't looked at seq file lately - could a user of it
> such as configfs impose a length limit of its choosing, building on

Quick look at the seq_file interfaces shows there is no such capability.
(disclaimer: I am no expert of seq_file :)

> your patch, without pushing the number of lines of code back above
> where it started?
> 
> Perhaps, say, we would let the callback routines could push stuff into
> a seq file without small limits, but then the configfs code could
> truncate that output to a limit of its choosing.  This would impose a
> length limit, safely.
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


