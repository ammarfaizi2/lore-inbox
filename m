Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262831AbUDOS3I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbUDOS3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 14:29:06 -0400
Received: from holomorphy.com ([207.189.100.168]:46465 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262831AbUDOS2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 14:28:22 -0400
Date: Thu, 15 Apr 2004 11:28:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Antony Suter <suterant@users.sourceforge.net>
Cc: List LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] highpmd for arch i386 PAE
Message-ID: <20040415182815.GB743@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Antony Suter <suterant@users.sourceforge.net>,
	List LKML <linux-kernel@vger.kernel.org>
References: <1082048738.8544.25.camel@hikaru.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082048738.8544.25.camel@hikaru.lan>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 03:05:38AM +1000, Antony Suter wrote:
> This patch places middle level pagetables into highmem, on PAE machines.
> It is relevant to arch/i386 machines running many processes on 4 to 64
> GB of RAM.
> This is simply a resync to the current kernel of a patch released by
> William Lee Irwin III about 4 months ago. WLI's comments on the patch
> are:

I'll be damned. This is one of the many pieces people never said much
about. Looks relatively thorough.

I did a few things to keep pmd caching around that look like they got
dropped, but I suppose for a standalone mainline port that's the only
option.

I'm really astounded ppl are going through the trouble of resurrecting
all this stuff. I suppose that means it was valuable to someone.


-- wli
