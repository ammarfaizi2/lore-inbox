Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbTEMQMU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbTEMQMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:12:15 -0400
Received: from hermes.ctd.anl.gov ([130.202.113.27]:51951 "EHLO
	hermes.ctd.anl.gov") by vger.kernel.org with ESMTP id S262227AbTEMQMI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 12:12:08 -0400
Message-ID: <3EC11C30.909660C9@anl.gov>
Date: Tue, 13 May 2003 11:24:16 -0500
From: "Douglas E. Engert" <deengert@anl.gov>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@warthog.cambridge.redhat.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [OpenAFS-devel] Re: [PATCH] in-core AFS multiplexor and PAG support
References: <8812.1052841957@warthog.warthog>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Transfer-Encoding: 7bit
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Howells wrote:
> 
> I'm not sure that the ability to arbitrarily join a PAG should be permitted,
> but it was requested.

This was a very handy feature which could be used with DCE/DFS. It is especially 
nice if the cost of obtaining credentials is high, vs the amount of 
processing being done, for example if the user is running a script, and doing 
multiple kerberos rsh commands to a host, if the rshd could join a PAG,
it would not need to received delegated credentials for each connection,
as it could use the credentials that where delegated earlier. 

It could can also be used as a way to refresh credentials. 



> 
> David
> _______________________________________________
> OpenAFS-devel mailing list
> OpenAFS-devel@openafs.org
> https://lists.openafs.org/mailman/listinfo/openafs-devel

-- 

 Douglas E. Engert  <DEEngert@anl.gov>
 Argonne National Laboratory
 9700 South Cass Avenue
 Argonne, Illinois  60439 
 (630) 252-5444
