Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263990AbTEFRBT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 13:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263992AbTEFRBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 13:01:19 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58897 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263990AbTEFRBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 13:01:18 -0400
Date: Tue, 6 May 2003 18:13:46 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: Marcus Meissner <meissner@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Only use MSDOS-Partitions by default on X86
Message-ID: <20030506181346.C15174@flint.arm.linux.org.uk>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
	Marcus Meissner <meissner@suse.de>, linux-kernel@vger.kernel.org
References: <20030505210811.GC7049@wohnheim.fh-wedel.de.suse.lists.linux.kernel> <1052218090.28792.15.camel@dhcp22.swansea.linux.org.uk.suse.lists.linux.kernel> <20030506120939.GB15261@wohnheim.fh-wedel.de.suse.lists.linux.kernel> <20030506122844.95332D872@Hermes.suse.de> <20030506124212.GE15261@wohnheim.fh-wedel.de> <20030506150318.C21775@flint.arm.linux.org.uk> <20030506153252.GA13830@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030506153252.GA13830@wohnheim.fh-wedel.de>; from joern@wohnheim.fh-wedel.de on Tue, May 06, 2003 at 05:32:52PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 05:32:52PM +0200, Jörn Engel wrote:
> Maybe I was just thinking the wrong way. Given that my systems don't
> use IDE, SCSI, a floppy or anything emulating one of them, like USB
> storage or CF. I don't want MSDOS partitioning, but in fact, I don't
> want any of the disk-centric code at all, fs/partitions is just a part
> of that.

Maybe introducing a CONFIG_DISK option and making partitioning as a whole
depend on that ?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

