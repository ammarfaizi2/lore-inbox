Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWCGFok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWCGFok (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 00:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWCGFok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 00:44:40 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:14685 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750764AbWCGFok convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 00:44:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cvOVFl2X3gdjb6JZtcFaH0oUyo0rXvghMh1Xw3DGuldxYnObflq9bZBl71wNmpsg0BCmWfrwlR+fbbyLOI5TmjzLJFkdcl6d4KczRepohN2c98ZUvwXbn2fBcRk5RwggNlQVgh7mFSARFrQ+mymoWT49+UDsD14ZpWSnRQEZZSo=
Message-ID: <f69849430603062144k484b62daq8f8aaa5b6b71d5f@mail.gmail.com>
Date: Mon, 6 Mar 2006 21:44:38 -0800
From: "kernel coder" <lhrkernelcoder@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: problem in NFS boot
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I'm trying to boot linux kernel 2.6.14 for arm architecure  with NFS
as root filesystem while using QEMU emulator.But the kernel hangs
after mounting the NFS as root filesystem.here is the output

IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 5, 131072 bytes)
TCP bind hash table entries: 8192 (order: 5, 163840 bytes)
<6>TCP: Hash tables configured (established 8192 bind 8192)
<6>TCP reno registered
<6>TCP bic registered
<6>NET: Registered protocol family 10
<6>IPv6 over IPv4 tunneling driver
<6>eth0: link up
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
device=eth0, addr=192.168.2.183, mask=255.255.255.0, gw=255.255.255.255,
host=192.168.2.183, domain=, nis-domain=(none),
bootserver=255.255.255.255, rootserver=192.168.2.182, rootpath=
<5>Looking up port of RPC 100003/2 on 192.168.2.182
<5>Looking up port of RPC 100005/1 on 192.168.2.182
VFS: Mounted root (nfs filesystem).

After the above line the kernel hangs.No error and no warning.Would u
please tell me what might be the cause of problem and how to debug it.

shahzad
