Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032026AbWLGLBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032026AbWLGLBH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 06:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032027AbWLGLBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 06:01:07 -0500
Received: from web27706.mail.ukl.yahoo.com ([217.146.177.240]:40241 "HELO
	web27706.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1032026AbWLGLBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 06:01:05 -0500
Message-ID: <20061207110104.74408.qmail@web27706.mail.ukl.yahoo.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=kYFjop86vYYK3Bae5DuCdemEKRUht0eE+3kuEAzxMGWGrbnwkVdlGDEQvnChZgX6zGdFFSVQb/w3o/OZhCgz2O3ZFXIaggox2QtnZmKUJv/t+MxpAd8DTOpbMmwONEuD6ImOxReud6dxf3tJadLujeB6X1lkGrmliVroA1ZpOL4=;
X-YMail-OSG: uifHeW8VM1l.xZk_gvtRbvykueyZAN9pR8JZe_ZbVQimzEwgRh_leqloHjuxxlZng6dly8IsS5Y7KxDOYYXXeli3LMjcdXSkmJuvegPuRi180w0qrobaVK5CXU2iF1HdVsaQd80czm5Y
Date: Thu, 7 Dec 2006 12:01:04 +0100 (CET)
From: zine el abidine Hamid <zine46@yahoo.fr>
Subject: Detecting I/O error and Halting System  : come back
To: linux-os@analogic.com, alan@lxorguk.ukuu.org.uk, be-news06@lina.inka.de,
       gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi evrybody,

I come back with my problem of "I/O error" (refer to
the following link to reffresh your mind :
http://groups.google.fr/group/linux.kernel/browse_thread/thread/386b69ca8389cda0/a58d753bf87c4f06?lnk=st&q=hamid+ZINE+EL+ABIDINE&rnum=2&hl=fr#a58d753bf87c4f06
)


I come back with a last question and I swear that I'll
stop annoying you with this problem.
Can you explain me why it seems that some part of the
hard drive are read only and others seems totaly
disepeared?
Some commands are available and works fine, others
generate an error like this : 

-bash: /bin/some_command: Input/output error

Can you explain that? 
Can I consider that the commands that are available
are in fact in the memory/cache and not read from the
hard drive?

Executing "e2fsck" turns sometimes in short : I got
"Bus error".
When I execute again "e2fsck" I optain this errors :
Error reading block XXXX ( Attempt to read block from
filesystem resulted in short read). Ignore error?
...
...
Inode XYZW (...) has bad mode (00).
Clear?
...



When I try to write to a file (that I can read and
that is not empty), I loose it ?(size = 0, and the
content seems to be gone away...)

Why, when I execute the shutdown commande, I got a bus
error?




Some Linux users pointed a journal commit problem;
what do you think about?
( see the link :
http://groups.google.fr/group/comp.os.linux.misc/browse_thread/thread/7b51af5a197d4ff3/facf167c3354a06f?lnk=st&q=bash+I%2FO+error&rnum=7&hl=fr#facf167c3354a06f
)


I googled and found that there are lot off similar
cases :
http://groups.google.fr/group/linux.redhat/browse_frm/thread/35cbedb6667755ed/64dc7232177c7dc8?lnk=st&q=bash%3A+Input%2Foutput+error&rnum=25&hl=fr#64dc7232177c7dc8
http://groups.google.fr/group/fa.linux.kernel/browse_frm/thread/87546535d17c674b/030caa62ad099af9?lnk=st&q=bash%3A+%2Fusr%2Fbin%2F%3A+Input%2Foutput+error&rnum=6&hl=fr#030caa62ad099af9
http://groups.google.fr/group/fa.linux.kernel/browse_frm/thread/60d92e4bb6a5f4db/18e69ef0d46448ac?lnk=st&q=bash%3A+%2Fusr%2Fbin%2F%3A+Input%2Foutput+error&rnum=10&hl=fr#18e69ef0d46448ac
http://groups.google.fr/group/comp.os.linux.misc/browse_frm/thread/a006864077740438/f08d570d516657c1?lnk=st&q=bash%3A+%2Fusr%2Fbin%2F%3A+Input%2Foutput+error&rnum=5&hl=fr#f08d570d516657c1
http://groups.google.fr/group/fa.linux.kernel/browse_frm/thread/60d92e4bb6a5f4db/18e69ef0d46448ac?lnk=st&q=bash%3A+%2Fusr%2Fbin%2F%3A+Input%2Foutput+error&rnum=10&hl=fr#18e69ef0d46448ac
http://groups.google.fr/group/alt.e-smith.fr/browse_frm/thread/44176232ffc3c1a6/5b35e4771b8030a7?lnk=st&q=bash%3A+%2Fusr%2Fbin%2F%3A+Input%2Foutput+error&rnum=63&hl=fr#5b35e4771b8030a7
http://groups.google.fr/group/comp.os.linux.misc/browse_frm/thread/137246f4bf738e2/b26503666b86972d?lnk=st&q=bash%3A+Input%2Foutput+error&rnum=3&hl=fr#b26503666b86972d
http://groups.google.fr/group/comp.os.linux.misc/browse_frm/thread/a006864077740438/f08d570d516657c1?lnk=st&q=bash%3A+Input%2Foutput+error&rnum=13&hl=fr#f08d570d516657c1
http://groups.google.fr/group/linux.gentoo.user/browse_frm/thread/678951cec2655493/54ed838422331550?lnk=st&q=bash%3A+Input%2Foutput+error&rnum=35&hl=fr#54ed838422331550



	

	
		
___________________________________________________________________________ 
Nouveau : téléphonez moins cher avec Yahoo! Messenger ! Découvez les tarifs exceptionnels pour appeler la France et l'international.
Téléchargez sur http://fr.messenger.yahoo.com
