Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVALVYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVALVYE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 16:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVALVWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:22:07 -0500
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:12173 "HELO
	server5.heliogroup.fr") by vger.kernel.org with SMTP
	id S261458AbVALVOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:14:55 -0500
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: akpm@osdl.org, torvalds@ppc970.osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Date: Wed, 12 Jan 2005 20:49:55 GMT
Message-ID: <050LZ7812@server5.heliogroup.fr>
X-Mailer: Pliant 93
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Where is 2.6.10.1 with the security fix only ?

I have not yet finished to deal with the TCP troubles moving to 2.6.10 generated
on my production server, and now, I should apply another large set of mainly
untested patches just to fill the security hole. This just cannot be done in
a fiew days because on many organisations, the new kernel has to pass several
days on secondary servers before reaching the main ones.

Now assuming that I have other production servers still running older kernels,
I have no way to get the simple fix from kernel.org and backport it to 2.6.8
and 2.6.9, unless I'm a kernel fulltime worker that reads all messages on kernel
mailing list.

Basically, you are currently leaving non distribution related users alone in the
cold and this is really really bad for the confidence we have in Linux,
so please publish a 2.6.10.1 with the short term solution to fix the hole.
Of course this does not prevent to publish 2.6.10.2 when you found a better
solution, or use a different fix in 2.6.11 since they are not based on 2.6.10.1

Regards,
Hubert Tonneau


PS: I believe that it would also be a very good idea, since Linux is now
expected to be a mature organisation, to automatically publish 2.6.x.y new holes
only fix patch for each stable kernel that has been released less than a year ago.
This would enable smoother upgrade of highly important production servers.

