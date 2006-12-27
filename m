Return-Path: <linux-kernel-owner+w=401wt.eu-S932928AbWL0GN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932928AbWL0GN5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 01:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932929AbWL0GN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 01:13:57 -0500
Received: from web8415.mail.in.yahoo.com ([202.43.219.103]:21065 "HELO
	web8415.mail.in.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932928AbWL0GN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 01:13:56 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Dec 2006 01:13:55 EST
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=gIbix+1KuFi6Ev76yERYR+F4m7kkP074pjDWx/r600e2Q94jIh0ylzo3rMjop+a0Pp1JEsLopICPdJxsMyncth0iY+ZRTeII1J2Yglb2qOyRSUWIcbOKX8U+bvaxe952NAZMNk71pYE48QuJ7+/gSafwGK7myVRUB3QPgwLZ/i4=  ;
Message-ID: <20061227060712.75821.qmail@web8415.mail.in.yahoo.com>
X-YMail-OSG: edLFMH0VM1nbm4mRPrThHu8vJ89Wp2J8Q0B2dAUs7eivabzgBxGtNhYU_Zz1EX3yvb7wAP9pa2EOSm5qykyA_FV4x_G_cCbC659AkagIHxlBDI3cZU9mBO_G6JHYJoNTNF5Xbj07I9I9.hD7M1EbNjPixQ--
Date: Wed, 27 Dec 2006 06:07:12 +0000 (GMT)
From: veerasena reddy <veerasena_b@yahoo.co.in>
Subject: problem with starting an application daemon from rcS script in case of lnux-2.6.18 kernel version. 
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wrote a small appication "test_shell" and started
the same as a background process ("test_shell&") from
"rcS" script to print a message "This is to test the
shell for daemon processes" on console for every ten
seconds.

For this, the rcS script contains the below command:
"test_shell &"

I have built two images for the target with the kernel
versions linux-2.6.18 and linux-mips-2.6.12.

In case of liunux-mips-2.6.12 i am able to see the
prints on the console.

In case of liunux-2.6.18 i am not getting the prints
on the console. if i try "ps" command i am able to see
the process running in the background.

In both kernel versions libraries and shell used are
same.

What could be the reason for this?
Please suggest me some solution for this.

Could any body please suggest an alternate solution to
start the application from the rcS as a daemon
"test_shell&" and still get the prints on the
console???

Thanks in advance.

Regards,
veeru.

Send free SMS to your Friends on Mobile from your Yahoo! Messenger. Download Now! http://messenger.yahoo.com/download.php
