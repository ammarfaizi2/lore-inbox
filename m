Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131042AbRCFRrW>; Tue, 6 Mar 2001 12:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131039AbRCFRrM>; Tue, 6 Mar 2001 12:47:12 -0500
Received: from [63.95.87.168] ([63.95.87.168]:38672 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S131038AbRCFRrA>;
	Tue, 6 Mar 2001 12:47:00 -0500
Date: Tue, 6 Mar 2001 12:46:59 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: David Balazic <david.balazic@uni-mb.si>
Cc: chromi@cyberspace.org, linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's
Message-ID: <20010306124659.B2244@xi.linuxpower.cx>
In-Reply-To: <3AA51AE7.29FAC080@uni-mb.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <3AA51AE7.29FAC080@uni-mb.si>; from david.balazic@uni-mb.si on Tue, Mar 06, 2001 at 06:14:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2001 at 06:14:15PM +0100, David Balazic wrote:
[snip]
> Hardware Level caching is only good for OSes which have broken
> drivers and broken caching (like plain old DOS).
> 
> Linux does a good job in caching and cache control at software
> level.

Read caching, yes. But for writes, the drive can often do a lot more
optimization because of it's synchronous operation with the platter and
greater knowledge of internal disk geometry.

What would be useful, as Alan said, is a barrier operation.
