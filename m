Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbTJAMQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 08:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbTJAMQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 08:16:56 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:33161 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262072AbTJAMQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 08:16:55 -0400
Date: Wed, 1 Oct 2003 14:16:43 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Al Smith <Al.Smith@aeschi.ch.eu.org>
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: include/linux/efs_fs.h declares a symbol
Message-ID: <20031001121643.GD31698@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Al, your version string cprt[] should better be in one of the .c files
and the declaration in the header be extern.  No need to keep six
seperate copies of that string in the kernel binary.

Thanks!

Al Viro: There is no maintainer for efs in the kernel MAINTAINERS
file.  Is this filesystem orphaned?

Jörn

-- 
But this is not to say that the main benefit of Linux and other GPL
software is lower-cost. Control is the main benefit--cost is secondary.
-- Bruce Perens
