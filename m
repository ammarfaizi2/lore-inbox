Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317979AbSFSTKI>; Wed, 19 Jun 2002 15:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317980AbSFSTKH>; Wed, 19 Jun 2002 15:10:07 -0400
Received: from rj.sgi.com ([192.82.208.96]:35733 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S317979AbSFSTKE>;
	Wed, 19 Jun 2002 15:10:04 -0400
Message-ID: <D93B36D3895ED51183870004AC38ABA7AD88B9@mtv-atc-006e--n.corp.sgi.com>
From: Gene Yee <gyee@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: SMBFS Problems: smb_proc_readdir_long: name=, result=-2, rcls=1, 
	err=123
Date: Wed, 19 Jun 2002 12:10:02 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is a quick overview:

I am able to make a connection to a Win2K share and access all the
directories and files, except one.  It is rather large also...  When I
access try to access the directory, it will leave the error:
smb_proc_readdir_long: name=, result=-2, rcls=1, err=123 in the
/var/messages.  It normally shows 0 files in the directory, but if I enter
'ls' enough times it will give me roughly half the files in the directory.
I am listing the properties of the directory below.

Size: 225GB (241,700,612,216 bytes)
Size on disk: 225GB (241,760,051,200 bytes)
Contains: 17,466 Files, 1,215 Folders

I was running 2.4.18 with the Hendrick patch to support a 160GB HD.  I have
since moved up to 2.4.19pre10 hoping the fix the samba problem, I have also
upgraded to the latest Samba on the server, thinking a new smbmount might
help. None of this made a difference. 

Let me know if there is any other information I can provide.

Any suggestion will be appreciated...
