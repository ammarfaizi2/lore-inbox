Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267337AbTALJNt>; Sun, 12 Jan 2003 04:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267336AbTALJNt>; Sun, 12 Jan 2003 04:13:49 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49924 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267337AbTALJNs>; Sun, 12 Jan 2003 04:13:48 -0500
Date: Sun, 12 Jan 2003 09:22:32 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: partitions and filesystems
Message-ID: <20030112092232.A29665@flint.arm.linux.org.uk>
Mail-Followup-To: "Robert P. J. Day" <rpjday@mindspring.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0301112323280.21000-100000@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0301112323280.21000-100000@dell>; from rpjday@mindspring.com on Sat, Jan 11, 2003 at 11:24:56PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 11:24:56PM -0500, Robert P. J. Day wrote:
>   is it reasonable to be able to select that you want to support
> Acorn filesystems while not selecting Acorn partition support?

Yes.  A natively formatted Acorn drive will only have one filesystem on
it without any form of partition table.  Even with a partition table,
/dev/hda or /dev/hda1 will be the same filesystem.

Obviously mounting both is not recommended.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

