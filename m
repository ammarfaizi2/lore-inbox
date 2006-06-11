Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWFKTa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWFKTa1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 15:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWFKTa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 15:30:27 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:50089 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750834AbWFKTa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 15:30:26 -0400
Subject: Re: Video drivers and System Management mode.
From: Lee Revell <rlrevell@joe-job.com>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <448C5BF0.7070601@superbug.demon.co.uk>
References: <448C5BF0.7070601@superbug.demon.co.uk>
Content-Type: text/plain
Date: Sun, 11 Jun 2006 15:30:31 -0400
Message-Id: <1150054232.14253.157.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-11 at 19:07 +0100, James Courtier-Dutton wrote:
> Hi,
> 
> I know we all laugh about the windows blue screen of death, but to be
> fair, when Linux oops, it is not even able to display anything on the
> screen, unless in dump terminal mode. I.e. Not X or some other GUI.
> 
> Are there any plans to implement a sort of interactive system management
> mode, that would pop up a window when Linux oops. Something like the
> program called SoftICE for windows would be a nice addition to Linux,
> and help with kernel development.

kdb would definitely be a good starting point.  But I don't think it
works if you're in X when the kernel crashes.

Lee

