Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264576AbTDPUKp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 16:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264577AbTDPUKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 16:10:45 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:65154 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264576AbTDPUKn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 16:10:43 -0400
Date: Wed, 16 Apr 2003 21:22:29 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andries.Brouwer@cwi.nl
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       torvalds@transmeta.com
Subject: Re: [PATCH] kill ide-geometry.c, fix boot problems
Message-ID: <20030416202229.GA30097@mail.jlokier.co.uk>
References: <UTC200304161802.h3GI2ch26701.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200304161802.h3GI2ch26701.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> Now the RedHat installer can do the remap in case it detects
> a disk manager. That is nice, because that means that in case of
> a whole-disk install it could ask the user whether she wants to
> preserve this animal. Probably she doesnt.

That is quite nice - ask user at install time whether to remove the
disk manager.

However, after doing that it seems appropriate for a booting kernel to
autodetect the presence or absence of the disk manager and behave
accordingly.

Just like the user gets to choose what goes in the partition table at
install time, and after that it is read automatically.

The user does not (usually) have to supply special kernel options to
tell it where the partitions are, or what the disk geometry is.  The
kernel can do that automatically.  So why does this not apply to known
disk manager remappings?

-- Jamie
