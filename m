Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264308AbUFKVxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264308AbUFKVxa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 17:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264337AbUFKVxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 17:53:30 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:57503 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264308AbUFKVx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 17:53:27 -0400
Date: Fri, 11 Jun 2004 23:53:18 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: urban@teststation.com, samba@samba.org
Cc: linux-kernel@vger.kernel.org, Bernhard Wesely <bernie@weselyb.net>
Subject: Re: Typo in fs/smbfs/file.c
Message-ID: <20040611215318.GA20046@wohnheim.fh-wedel.de>
References: <50746.10.100.5.81.1086988491.squirrel@mail.brumma.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50746.10.100.5.81.1086988491.squirrel@mail.brumma.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 June 2004 23:14:51 +0200, Bernhard Wesely wrote:
> 
> I recently compiled 2.6.6 and got a gcc warning:
> 
>   CC      fs/smbfs/file.o
> fs/smbfs/file.c: In function `smb_file_sendfile':
> fs/smbfs/file.c:274: warning: unknown conversion type character `z' in format
> fs/smbfs/file.c:274: warning: too many arguments for format
> 
> Well, there seems to be a "z" instead of a "Z". I changed it and the
> compile went cleanly. I downloaded the source of 2.6.7-rc3 and the typo
> was still there.
> 
> The fixed line looks like:
> 
> PARANOIA("%s/%s validation failed, error=%Zd\n", DENTRY_PATH(dentry),
> status);

Just forwarding to the correct hands (as of MAINTAINERS file).

Jörn

-- 
The wise man seeks everything in himself; the ignorant man tries to get
everything from somebody else.
-- unknown
