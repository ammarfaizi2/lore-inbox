Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbTLSO07 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 09:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbTLSO07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 09:26:59 -0500
Received: from holomorphy.com ([199.26.172.102]:11415 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263244AbTLSO06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 09:26:58 -0500
Date: Fri, 19 Dec 2003 06:26:54 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Kevin Douglas <kevindouglas@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Compiler error for 2.6.0 in fs/proc/array.c
Message-ID: <20031219142654.GQ31393@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Kevin Douglas <kevindouglas@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20031219141531.13031.qmail@web40809.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031219141531.13031.qmail@web40809.mail.yahoo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 19, 2003 at 06:15:31AM -0800, Kevin Douglas wrote:
> Compiler error for 2.6.0 in fs/proc/array.c with gcc-2.95 and binutils
> 2.13.
> I received the following error while trying to compile the new 2.6.0
> (no -test anything) on my RH 7.3 box.  I have gcc version 2.95.3
> installed in addion to the yuckie 2.96 from RH.  While search the
> mailing list archives, I found some patches for the -test7 and/or
> -test8 series that claim they fix a gcc 2.96 bug.  I applied the patch
> on the original 2.6.0 source tree and the compile went through.  The
> patch I'm talking about involved making the tty_nr variable into a
> volatile int in the file fs/proc/array.c line number 298.  There are
> other patches that attempt to break up the huge sprintf() statement on
> line 347 into smaller chucks.  I'm not sure which would be preferable
> to the maintainer.
> The point of this email is to hopefully bring to your attention a
> compilation bug in the 2.6.0 source.  If I made a mistake and don't
> have my environment set up correctly, please accept my appologies.
> Hope this helps,
> -kevin

What you have found is actually a gcc bug. Upgrade gcc!

-- wli
