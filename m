Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262244AbVCSANf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbVCSANf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 19:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbVCSANf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 19:13:35 -0500
Received: from moutng.kundenserver.de ([212.227.126.173]:5066 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262244AbVCSADD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 19:03:03 -0500
To: Chris Wright <chrisw@osdl.org>
Cc: Alexander Nyberg <alexn@dsv.su.se>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, rmk+lkml@arm.linux.org.uk
Subject: Re: Capabilities across execve
References: <1110627748.2376.6.camel@boxen>
	<20050313032117.GA28536@shell0.pdx.osdl.net>
	<20050315215719.A12283@flint.arm.linux.org.uk>
	<20050315224219.GA5389@shell0.pdx.osdl.net>
	<1110930112.1210.44.camel@localhost.localdomain>
	<20050315235851.GF5389@shell0.pdx.osdl.net>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Sat, 19 Mar 2005 01:02:43 +0100
In-Reply-To: <20050315235851.GF5389@shell0.pdx.osdl.net> (Chris Wright's
 message of "Tue, 15 Mar 2005 15:58:51 -0800")
Message-ID: <873busijto.fsf@goat.bogus.local>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> writes:

> * Alexander Nyberg (alexn@dsv.su.se) wrote:
>> I can see useful scenarios of having the possiblity of capabilities per
>> inode (it appears the xattr way wins somewhat in the previous
>> discussion).
>
> It's how it should be done.

I agree to disagree :-)

>> Chris, have you seen any capabilities+xattr patches around?
>
> http://www.kernel.org/pub/linux/libs/security/linux-privs/kernel-2.4-fcap/

Which is pretty useless, since it doesn't apply to any recent
(> 2.4.3) kernel. If you insist on a xattr based approach, take
Andy Lutomirski's <http://www.stanford.edu/~luto/linux-fscap/>
patch. It is more recent, a lot smaller and considerably more
understandable (at least for me ;-).

Regards, Olaf.
