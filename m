Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262478AbTCMRn7>; Thu, 13 Mar 2003 12:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262482AbTCMRn7>; Thu, 13 Mar 2003 12:43:59 -0500
Received: from ip5.searssiding.com ([216.54.166.5]:56279 "EHLO
	encc2.encore.com") by vger.kernel.org with ESMTP id <S262478AbTCMRn6>;
	Thu, 13 Mar 2003 12:43:58 -0500
Message-ID: <3E70C6B8.C5D98C1C@compro.net>
Date: Thu, 13 Mar 2003 12:58:16 -0500
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-lcrs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: uaca@alumni.uv.es
Cc: linux-kernel@vger.kernel.org
Subject: Re: is irq smp affinity good for anything?
References: <20030311140458.GA15465@pusa.informat.uv.es> <Pine.LNX.4.44.0303112047240.15753-100000@coffee.psychology.mcmaster.ca> <20030312101116.GB12206@pusa.informat.uv.es> <3E7076E1.6F7C74B1@compro.net> <20030313154726.GB24636@pusa.informat.uv.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

uaca@alumni.uv.es wrote:
> 
> Thanks so much for your comments
> 
> Yes... maybe there is also cache pingpong because common locks are in
> different cpus... I'will try it
> 
> do you know what's the best/less intrusive patch that allows
> task cpu binding?
             <---
Probably the least intrusive can be gotten here:

http://www.kernel.org/pub/linux/kernel/people/rml/cpu-affinity/

Or the O(1) schedular patches. That is a little more intrusive though.

Mark
