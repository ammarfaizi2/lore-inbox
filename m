Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275981AbRJLR4b>; Fri, 12 Oct 2001 13:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277702AbRJLR4W>; Fri, 12 Oct 2001 13:56:22 -0400
Received: from cx680915-a.cv1.sdca.home.com ([24.177.181.157]:6897 "EHLO
	rei.moonkingdom.net") by vger.kernel.org with ESMTP
	id <S277271AbRJLR4M>; Fri, 12 Oct 2001 13:56:12 -0400
Date: Fri, 12 Oct 2001 10:56:43 -0700
To: linux-kernel@vger.kernel.org
Subject: Re: No love for the PPC
Message-ID: <20011012105643.C30739@moonkingdom.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0110121002200.13818-100000@asuka.nerv-9.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0110121002200.13818-100000@asuka.nerv-9.net>
User-Agent: Mutt/1.3.22i
From: Marc Wilson <mwilson@moonkingdom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2001 at 10:08:39AM -0700, Mike Borrelli wrote:
> It isn't even big problems either.  A single line (#include
> <linux/pm.h>) is missing from pc_keyb.c and has been for at least three
> -ac releases.  Now, process.c in arch/ppc/kernel/ dies from an undeclared
> identifier (init_mmap).
> 
> Anyway, the real question is, why does the ppc arhitecture /always/ break
> between versions?

An -ac kernel is SUPPOSED to break.  It's not a release kernel.  WHEN it
breaks, it gets fixed, and then it becomes a release kernel.

Seems simple enough.

If you want intermediate kernel revisions that don't break, head over to
http://penguinppc.org and look at how to rsync yourself a benh or bk
kernel tree.

-- 
Marc Wilson
mwilson@moonkingdom.net
mwilson@cts.com

