Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129556AbQKQQbQ>; Fri, 17 Nov 2000 11:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129270AbQKQQbH>; Fri, 17 Nov 2000 11:31:07 -0500
Received: from [216.23.11.247] ([216.23.11.247]:13575 "EHLO seapine.com")
	by vger.kernel.org with ESMTP id <S129368AbQKQQax>;
	Fri, 17 Nov 2000 11:30:53 -0500
To: linux-kernel@vger.kernel.org
Subject: FAQ followup: changes in open fd/proc in 2.4.x?
From: Doug Alcorn <doug@lathi.net>
Date: 17 Nov 2000 10:58:12 -0500
Message-ID: <m38zqitwtn.fsf@balder.seapine.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-Return-Path: doug@lathi.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am working on a project to port a commercial app to Linux.  Our app
is essentially a dataserver with approximately two files per database
table.  I did a search of this mailing lists archive on the subject
and found a discussion back in the 2.0.x days when the limit was 256.
Basically the discussion went like this:

guy who wanted more: I really need more fds
list: redesign your app
guy who wanted more: But my app is really mature
list: no response

I couldn't find any of the discussion from when the limit was
increased.

With the 2.2.x kernel, our choices are basically to live with the
limitation or redesign.  We certainly don't like the limitation and
are talking about a redesign.

Now we get to the reason for this post.  Has anything changed for
2.4.x?  With release eminent, we don't really want to go through the
redesign and implementation if the architecture is different for
2.4.x.  I don't closely follow linux-kernel (except through periodic
catch-ups on the kernel cousin).  It seems like the VFS changes might
affect this, I don't know.

So basically, before we begin the arduous task of redesign is there
anything in the 2.4.x kernel that will affect our decisions?

PS, please CC: me on replies.
-- 
 (__)  Doug Alcorn (mailto:doug@lathi.net http://www.lathi.net)
 oo /  
 |_/   

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
