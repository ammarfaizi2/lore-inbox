Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262311AbTCMNZp>; Thu, 13 Mar 2003 08:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262313AbTCMNZp>; Thu, 13 Mar 2003 08:25:45 -0500
Received: from ns.suse.de ([213.95.15.193]:39696 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262311AbTCMNZ2>;
	Thu, 13 Mar 2003 08:25:28 -0500
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.64-mm6
References: <20030313032615.7ca491d6.akpm@digeo.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 13 Mar 2003 14:36:14 +0100
In-Reply-To: Andrew Morton's message of "13 Mar 2003 12:30:11 +0100"
Message-ID: <p73n0jz4cdt.fsf@amdsimf.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:


>   This means that large cache-cold executables start significantly faster.
>   Launching X11+KDE+mozilla goes from 23 seconds to 16.  Starting OpenOffice
>   seems to be 2x to 3x faster, and starting Konqueror maybe 3x faster too. 
>   Interesting.
> 
>   This might cause weird thing to happen, especially on small-memory machines.

That's great. It would be nice to have this as a sysctl or perhaps
some heuristic based on file size and available memory for 2.6.

-Andi

