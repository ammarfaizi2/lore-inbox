Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265913AbUFISxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265913AbUFISxe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 14:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUFISxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 14:53:34 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:38584 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265913AbUFISxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 14:53:33 -0400
Date: Wed, 9 Jun 2004 20:53:32 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Chris Mason <mason@suse.com>
Cc: Hans Reiser <reiser@namesys.com>, reiserfs-dev@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: [STACK] >3k call path in reiserfs
Message-ID: <20040609185332.GF2950@wohnheim.fh-wedel.de>
References: <20040609122226.GE21168@wohnheim.fh-wedel.de> <1086784264.10973.236.camel@watt.suse.com> <1086800028.10973.258.camel@watt.suse.com> <40C74388.20301@namesys.com> <20040609172843.GB2950@wohnheim.fh-wedel.de> <40C75273.7020508@namesys.com> <1086806933.10973.299.camel@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1086806933.10973.299.camel@watt.suse.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 June 2004 14:48:54 -0400, Chris Mason wrote:
> 
> It's pretty important, especially when you toss NFS into the call path
> the stack usage can go higher.  The switch to kmalloc will be relatively
> small and by now we're good at testing for schedule bugs.

How can that happen?  Ignoring recursions, the data given should
already be the theoretical maximum.  Otherwise, please show me where
my tool makes a non-pessimistic choice.

[ Actually, I still miss callback functions.  Known bug. ]

Jörn

-- 
Public Domain  - Free as in Beer
General Public - Free as in Speech
BSD License    - Free as in Enterprise
Shared Source  - Free as in "Work will make you..."
