Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130119AbRAZT4T>; Fri, 26 Jan 2001 14:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130449AbRAZT4J>; Fri, 26 Jan 2001 14:56:09 -0500
Received: from foozle.turbogeek.org ([216.233.172.106]:34308 "EHLO
	foozle.turbogeek.org") by vger.kernel.org with ESMTP
	id <S130119AbRAZTzx>; Fri, 26 Jan 2001 14:55:53 -0500
Date: Fri, 26 Jan 2001 13:55:54 -0600
From: "Jeremy M. Dolan" <jmd@foozle.turbogeek.org>
To: linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
Message-ID: <20010126135554.A527@foozle.turbogeek.org>
In-Reply-To: <20010126161338.N3849@marowsky-bree.de> <Pine.SOL.4.21.0101261528190.16539-100000@red.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SOL.4.21.0101261528190.16539-100000@red.csi.cam.ac.uk>; from jas88@cam.ac.uk on Fri, Jan 26, 2001 at 03:29:51PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jan 2001 15:29:51 +0000, James Sutherland wrote:
> Except you can't retry without ECN, because DaveM wants to do a Microsoft
> and force ECN on everyone, whether they like it or not.

Who's forcing? You have to *SPECIFICALLY* enable it in the config,
ignoring the notice in the help text that there are "many" sites that
will be unaccessible to you with this feature turned on.

In a (barely) related note, I'm reminded of SYN cookies. Are there
certain firewalls/hosts out there that choke on these as well? If not,
why are they still disabled by default, not only required to be
config'd in, but to set a sysctl each run. (Even more work then ECN!)

Also, is there any way to force SYN cookies for all connections, not
just have them sent out when the queue is full?

/jmd (Who is waiting for the ZDNet story, "Linux 2.4 baned from .uk")
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
