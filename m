Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266947AbUAXOuX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 09:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266948AbUAXOuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 09:50:23 -0500
Received: from smtp.netcabo.pt ([212.113.174.9]:58990 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S266947AbUAXOuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 09:50:20 -0500
Date: Sat, 24 Jan 2004 14:46:23 +0000
From: backblue <backblue@netcabo.pt>
To: linux-kernel@vger.kernel.org
Subject: weird problem with ssh
Message-Id: <20040124144623.717dd092.backblue@netcabo.pt>
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jan 2004 14:50:11.0857 (UTC) FILETIME=[5E64D810:01C3E289]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem with ssh non-commercial, and i think it's 2.6.1 problem! in 2.4 series works great, when i try to ssh to one of my machines, see for your self... what can it be?

$ ssh -V
ssh: SSH Secure Shell 3.2.9.1 (non-commercial version) on i686-pc-linux-gnu


$ ssh forbidden
Host key not found from database.
Key fingerprint:
xesad-cubil-bahel-ganic-vezaz-kevul-fivab-kapih-tylyp-kutid-myxax
You can get a public key's fingerprint by running
% ssh-keygen -F publickey.pub
on the keyfile.
warning: tcsetattr failed in ssh_rl_set_tty_modes_for_fd: fd 1: Interrupted system call
Received signal 2. (no core)
$


$ strace -o log ssh forbidden
Host key not found from database.
Key fingerprint:
xesad-cubil-bahel-ganic-vezaz-kevul-fivab-kapih-tylyp-kutid-myxax
You can get a public key's fingerprint by running
% ssh-keygen -F publickey.pub
on the keyfile.
Are you sure you want to continue connecting (yes/no)? yes
Host key saved to /home/backblue/.ssh2/hostkeys/key_22_forbidden.pub
host key for forbidden, accepted by backblue Sat Jan 24 2004 14:41:21
backblue's password: 
Authentication successful.
Last login: Thu Jan 22 2004 22:50:10 from fork.ketic.com
Linux 2.4.24.
No mail.
backblue@forbidden:~$ logout
Connection to forbidden closed.
$


$ ssh forbidden
backblue's password: 
Authentication successful.
Last login: Sat Jan 24 2004 14:40:44 from fork.ketic.com
Linux 2.4.24.
No mail.
backblue@forbidden:~$ 
backblue@forbidden:~$ logout
Connection to forbidden closed.
