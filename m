Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263732AbTEFNvq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 09:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263725AbTEFNu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 09:50:59 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22287 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263726AbTEFNuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 09:50:52 -0400
Date: Tue, 6 May 2003 15:03:18 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: Marcus Meissner <meissner@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Only use MSDOS-Partitions by default on X86
Message-ID: <20030506150318.C21775@flint.arm.linux.org.uk>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
	Marcus Meissner <meissner@suse.de>, linux-kernel@vger.kernel.org
References: <20030505210811.GC7049@wohnheim.fh-wedel.de.suse.lists.linux.kernel> <1052218090.28792.15.camel@dhcp22.swansea.linux.org.uk.suse.lists.linux.kernel> <20030506120939.GB15261@wohnheim.fh-wedel.de.suse.lists.linux.kernel> <20030506122844.95332D872@Hermes.suse.de> <20030506124212.GE15261@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030506124212.GE15261@wohnheim.fh-wedel.de>; from joern@wohnheim.fh-wedel.de on Tue, May 06, 2003 at 02:42:12PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 02:42:12PM +0200, Jörn Engel wrote:
> On Tue, 6 May 2003 14:28:44 +0200, Marcus Meissner wrote:
> > 
> > Every platform that supports USB will be able to read USB Storage
> > Devices which almost everytime have FAT filesystems with MSDOS partitions.
> > 
> > So short of S/390 you get like every platform.
> 
> And short of most embedded systems.

CF cards - these have MSDOS partition tables on.  CF cards get used on
embedded systems.

Therefore, it follows that if you have an embedded system with a CF socket,
you'll probably want the MSDOS partitioning enabled.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

