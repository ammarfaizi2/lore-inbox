Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbTEFM3p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 08:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbTEFM3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 08:29:45 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:62164 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262700AbTEFM3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 08:29:45 -0400
Date: Tue, 6 May 2003 14:42:12 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Marcus Meissner <meissner@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Only use MSDOS-Partitions by default on X86
Message-ID: <20030506124212.GE15261@wohnheim.fh-wedel.de>
References: <20030505210811.GC7049@wohnheim.fh-wedel.de.suse.lists.linux.kernel> <1052218090.28792.15.camel@dhcp22.swansea.linux.org.uk.suse.lists.linux.kernel> <20030506120939.GB15261@wohnheim.fh-wedel.de.suse.lists.linux.kernel> <20030506122844.95332D872@Hermes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030506122844.95332D872@Hermes.suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003 14:28:44 +0200, Marcus Meissner wrote:
> 
> Every platform that supports USB will be able to read USB Storage
> Devices which almost everytime have FAT filesystems with MSDOS partitions.
> 
> So short of S/390 you get like every platform.

And short of most embedded systems.

Wouldn't it make more sense to add USB to the positive list then?

(There is still the alternative in the back of my head, to add all the
mainly embedded cpus to the current negative list, until more people
agree that it is ugly.;)

Jörn

-- 
If you're willing to restrict the flexibility of your approach,
you can almost always do something better.
-- John Carmack
