Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315997AbSENTEO>; Tue, 14 May 2002 15:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315998AbSENTEN>; Tue, 14 May 2002 15:04:13 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:5274 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315997AbSENTEM>;
	Tue, 14 May 2002 15:04:12 -0400
Date: Tue, 14 May 2002 15:04:11 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
cc: mark@mark.mielke.cc, elladan@eskimo.com,
        Christoph Hellwig <hch@infradead.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed
In-Reply-To: <200205141854.NAA59350@tomcat.admin.navo.hpc.mil>
Message-ID: <Pine.GSO.4.21.0205141502530.4648-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 May 2002, Jesse Pollard wrote:
 
> However, not all daemons run as root, but do log into /var/adm or /var/log.
> If these fill up the log device without restraint, then your audit logs will
> ALSO be affected (unless you have syslog send them to a different host).

syslogd _does_ run as root and it can happily overflow the damn thing,
reserved blocks or not.

