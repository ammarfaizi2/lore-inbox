Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932900AbWKSTAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932900AbWKSTAM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 14:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932873AbWKSTAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 14:00:12 -0500
Received: from cantor2.suse.de ([195.135.220.15]:13220 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932900AbWKSTAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 14:00:11 -0500
From: Andi Kleen <ak@suse.de>
To: Jeff Mahoney <jeffm@suse.com>
Subject: Re: reiserfs NET=n build error
Date: Sun, 19 Nov 2006 19:59:55 +0100
User-Agent: KMail/1.9.5
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>, reiserfs-dev@namesys.com,
       sam@ravnborg.org, Al Viro <viro@ftp.linux.org.uk>
References: <20061118202206.01bdc0e0.randy.dunlap@oracle.com> <200611190650.49282.ak@suse.de> <45608FC2.5040406@suse.com>
In-Reply-To: <45608FC2.5040406@suse.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611191959.55969.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I would copy a relatively simple C implementation, like arch/h8300/lib/checksum.c
> 
> As long as the h8300 version has the same output as the x86 version.

The trouble is that the different architecture have different output 
for csum_partial. So you already got a bug when someone wants to move
file systems.

-Andi
