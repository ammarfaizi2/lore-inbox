Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbUCHTkq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 14:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbUCHTkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 14:40:46 -0500
Received: from grassmarket.ucs.ed.ac.uk ([129.215.166.64]:5611 "EHLO
	grassmarket.ucs.ed.ac.uk") by vger.kernel.org with ESMTP
	id S261160AbUCHTkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 14:40:43 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Reply-To: s0348365@sms.ed.ac.uk
Organization: University of Edinburgh
Subject: Re: 2.6.4-rc2-mm1
Date: Mon, 8 Mar 2004 19:44:01 +0000
User-Agent: KMail/1.6
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403081944.01964.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 March 2004 06:32, you wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4-rc2/2.6
>.4-rc2-mm1/
>
>
> - Added Jens's patch which teaches the kernel to use DMA when reading
>   audio from IDE CDROM drives.  These devices tend to be flakey, and we
>   need lots of testing please.
[snip]

This seems to work okay. When ripping a CD, cdparanoia's CPU utilisation
 never peaks beyond 4.0%. Very nice.

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
  445 alistair  18   0  5008 3428 1576 R  4.0  0.7   0:06.25 cdparanoia

No crashes so far. I'll try some bad discs and see how it recovers.

--
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/AI Undergraduate
contact:    7/10 Darroch Court,
            University of Edinburgh.
