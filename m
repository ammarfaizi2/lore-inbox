Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbUE1C54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUE1C54 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 22:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUE1C5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 22:57:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20375 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262106AbUE1C5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 22:57:53 -0400
Date: Thu, 27 May 2004 22:57:46 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: John Cherry <cherry@osdl.org>
cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-rc1-mm1 (compile stats)
In-Reply-To: <1085675112.4249.33.camel@cherrybomb.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0405272254590.30062-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2004, John Cherry wrote:

>   CC      arch/i386/kernel/dmi_scan.o
> arch/i386/kernel/dmi_scan.c:410: warning: `set_8042_nomux' defined but
> not used

It's called from the dmi routines, with the function
defined in the DMI table.  No idea why this would
give a warning while the other similar functions
(eg broken_ps2_resume) don't ...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

