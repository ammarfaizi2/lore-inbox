Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276594AbRJKRf5>; Thu, 11 Oct 2001 13:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276622AbRJKRfr>; Thu, 11 Oct 2001 13:35:47 -0400
Received: from a1as09-p75.stg.tli.de ([195.252.189.75]:23710 "EHLO
	dea.linux-mips.net") by vger.kernel.org with ESMTP
	id <S276594AbRJKRf3>; Thu, 11 Oct 2001 13:35:29 -0400
Date: Thu, 11 Oct 2001 19:25:20 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Christopher Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: unkillable process in R state?
Message-ID: <20011011192520.A27394@dea.linux-mips.net>
In-Reply-To: <Pine.SOL.4.33.0110111645410.18253-100000@yellow.csi.cam.ac.uk> <3BC5CD56.2E69C578@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BC5CD56.2E69C578@nortelnetworks.com>; from cfriesen@nortelnetworks.com on Thu, Oct 11, 2001 at 12:48:22PM -0400
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2001 at 12:48:22PM -0400, Christopher Friesen wrote:

> I have a process (an instance of a find command) that seems to be
> unkillable (ie kill -9 <pid> as root doesn't work).
> 
> Top shows it's status as R.
> 
> Is there anything I can do to kill the thing? It's taking up all unused cpu
> cycles (currently at 97.4%).

I assume that's kapm-idled.  That's normal, it's job is exactly burning
unused cycles.

  Ralf
