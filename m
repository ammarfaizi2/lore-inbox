Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262626AbUKRJcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbUKRJcd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 04:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbUKRJcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 04:32:33 -0500
Received: from janus2.sad.it ([192.106.213.194]:31954 "HELO sad.it")
	by vger.kernel.org with SMTP id S262626AbUKRJc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 04:32:28 -0500
Date: Thu, 18 Nov 2004 10:32:22 +0100
From: Fabrizio Tivano <fabrizio@sad.it>
To: linux-kernel@vger.kernel.org
Subject: Random freeze on CS 5530
Message-Id: <20041118103222.044722e8.fabrizio@sad.it>
Organization: SAD Trasporto Locale s.p.a.
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello dear all, 

I dont know if this is the right place to post 
my problem, but i try! :)


I have some machines GEODE based:

 Cyrix Corporation 5530 SMI [Kahlua]

Actually with kernel 2.4.24

Randomly, apparently without no reason, the pc 
freeze.

telnet from remote:
'Connection closed by foregn host'

If i plug video+key i see a lot of error messages
in console like:

===========
ext3-fs error (device ide03,400):ext3_get_inode_lock
ext3_resercve_inode_write: IO failure
===========

it seem that the system are unable to communicate
with the HDD and vice-versa.

...and the only  operation permitted is OFF then ON.

After the RESET all the system appears UP and ready
and the log files do not say nothing!
...and the last message on the syslog are the last
before the freeze; in some case I been able to see,
some time before the block,

this message:

====================
ide timeout, irq {busy}
reset
====================
in the last days i see this post:

http://groups.google.it/groups?hl=it&lr=&threadm=ag05ab%241gc%241%40penguin.transmeta.com&rnum=7&prev=/groups%3Fhl%3Dit%26lr%3D%26selm%3Dag05ab%25241gc%25241%2540penguin.transmeta.com%26rnum%3D7

Could be my problem ralted to this old post?

.....you have some ideas?

every hint will be really appreciated ! :)


Thanks in advance, 
fabrizio
