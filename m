Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTEVNuZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 09:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbTEVNuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 09:50:25 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16145 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261863AbTEVNuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 09:50:24 -0400
Date: Thu, 22 May 2003 15:03:26 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: LW@KARO-electronics.de
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >= 2.5.30(at least))
Message-ID: <20030522150325.B12171@flint.arm.linux.org.uk>
Mail-Followup-To: LW@KARO-electronics.de, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-arm-kernel@lists.arm.linux.org.uk
References: <16076.50160.67366.435042@ipc1.karo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16076.50160.67366.435042@ipc1.karo>; from LW@KARO-electronics.de on Thu, May 22, 2003 at 02:34:56PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 02:34:56PM +0200, LW@KARO-electronics.de wrote:
> in file 'mm/filemap.c' a call to 'flush_dcache_page' is missing as a
> replacement for the obsoleted 'flush_page_to_ram' call that was
> present there in older kernels.

Please refrain from cross-posting between member-only posting lists and
people not on those lists.  If you need to send the message to such a
list, please forward it there instead.

Anyone replying to this message and who aren't on linux-arm-kernel,
please drop this list from the CC: line.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

