Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289252AbSAVKld>; Tue, 22 Jan 2002 05:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289255AbSAVKlW>; Tue, 22 Jan 2002 05:41:22 -0500
Received: from mons.uio.no ([129.240.130.14]:14018 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S289252AbSAVKlO> convert rfc822-to-8bit;
	Tue, 22 Jan 2002 05:41:14 -0500
To: Rainer Krienke <krienke@uni-koblenz.de>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
        nfs@lists.sourceforge.net
Subject: Re: 2.4.17:Increase number of anonymous filesystems beyond 256?
In-Reply-To: <mailman.1011275640.16596.linux-kernel2news@redhat.com>
	<200201171855.g0HIt1314492@devserv.devel.redhat.com>
	<200201221025.g0MAP8Y14023@bliss.uni-koblenz.de>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 22 Jan 2002 11:40:58 +0100
In-Reply-To: <200201221025.g0MAP8Y14023@bliss.uni-koblenz.de>
Message-ID: <shszo36pt1h.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Rainer Krienke <krienke@uni-koblenz.de> writes:


     > portmap: connect from 127.0.0.1 to set(nfs): request from
     > unprivileged port rpc.nfsd: nfssvc: error Permission denied

     > A strace of nfsd shows the problem: ...  nfsservctl(0,
     > 0xbfffeed8, 0) = -1 EACCES (Permission denied) ...

'man 5 exports'

       secure This option requires that requests originate on  an
              internet  port  less  than  IPPORT_RESERVED (1024).
              This option is on by default. To turn it off, spec­
              ify insecure.

Cheers,
  Trond
