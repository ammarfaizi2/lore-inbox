Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287502AbSAXLa2>; Thu, 24 Jan 2002 06:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287532AbSAXLaR>; Thu, 24 Jan 2002 06:30:17 -0500
Received: from pat.uio.no ([129.240.130.16]:18173 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S287502AbSAXLaC>;
	Thu, 24 Jan 2002 06:30:02 -0500
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Error with Root-fs on NFS...
In-Reply-To: <Pine.LNX.4.30.0201241036100.29293-100000@mustard.heime.net>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 24 Jan 2002 12:29:52 +0100
In-Reply-To: <Pine.LNX.4.30.0201241036100.29293-100000@mustard.heime.net>
Message-ID: <shs1yggdm1b.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Roy Sigurd Karlsbakk <roy@karlsbakk.net> writes:

     > Hi all I apologize if this is a well-known error, but after
     > searching all archives I can think of, including google, I
     > still can't find anything but questions.

     > Version: linux-2.4.17+Tux2.4.17a0+rmap11c+ide2.4.17.01192002

     > sockets 1.0/SMP for Linux NET4.0.  Looking up port of RPC
     > 100003/2 on 192.168.144.247 RPC: sendmsg returned error 101
     > portmap: RPC call returned error 101 Root-NFS: Unable to get
     > nfsd port number from server, using default Looking up port of
     > RPC 100005/1 on 192.168.144.247 RPC: sendmsg returned error 101
     > portmap: RPC call returned error 101 Root-NFS: Unable to get
     > mountd port number from server, using default RPC: sendmsg
     > returned error 101 mount: RPC call returned error 101 Root-NFS:
     > Server returned error -101 while mounting /croot VFS: Unable to
     > mount root fs via NFS, trying floppy.

Well:
      Is there a portmapper running on the server?
      Is it accessible to the client (/etc/hosts.{allow,deny}, ipchains,...)?
      Is the portmapper advertising NFS version 2 (BTW: the syntax is 'v3' not 'nfsvers=3' on NFSroot)?
      Is it advertising mountd version 1?

Cheers,
  Trond
