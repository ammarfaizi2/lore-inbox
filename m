Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268948AbTBZV4a>; Wed, 26 Feb 2003 16:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269169AbTBZV4a>; Wed, 26 Feb 2003 16:56:30 -0500
Received: from mail2.linuxis.net ([64.71.140.142]:64457 "HELO
	moria.linuxis.net") by vger.kernel.org with SMTP id <S268948AbTBZV43>;
	Wed, 26 Feb 2003 16:56:29 -0500
Date: Wed, 26 Feb 2003 13:51:56 -0800
From: Adam McKenna <adam@flounder.net>
To: linux-kernel@vger.kernel.org
Subject: Re: VM problems in 2.4.20
Message-ID: <20030226215156.GB14293@flounder.net>
Mail-Followup-To: Adam McKenna <adam@flounder.net>,
	linux-kernel@vger.kernel.org
References: <20030226194043.GA14293@flounder.net> <200302262101.57367.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302262101.57367.m.c.p@wolk-project.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2003 at 09:04:52PM +0100, Marc-Christian Petersen wrote:
> On Wednesday 26 February 2003 20:40, Adam McKenna wrote:
> 
> Hi Adam,
> 
> > I'm having a VM issue on one of my servers running 2.4.20.
> well, the vanilla VM, hmm, sorry: sucks :) for large boxen.

Can you expand on "sucks"?  4GB is not really that large of a system anymore.

I still don't see how this memory taken up by buffers/cache is not freed when
a system process needs it.  I have always thought that this type of memory is
by definition "lower priority", and should be dropped when a process needs
more memory.  Is this not the case?

--Adam
