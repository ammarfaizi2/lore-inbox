Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269423AbRHGUtK>; Tue, 7 Aug 2001 16:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269428AbRHGUtA>; Tue, 7 Aug 2001 16:49:00 -0400
Received: from [63.194.239.202] ([63.194.239.202]:37362 "EHLO
	mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S269423AbRHGUsx>; Tue, 7 Aug 2001 16:48:53 -0400
Date: Tue, 7 Aug 2001 13:48:30 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x IP aliase max eth0:16 (16 aliases), where to change?
Message-ID: <20010807134830.B22821@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0108072238160.20904-100000@data.wipol.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0108072238160.20904-100000@data.wipol.uni-bonn.de>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2001 at 10:41:27PM +0200, Noel Koethe wrote:
> Hello,
> 
> The maximum aliases I can configure with a 2.4.x kernel is 16, right?
> 
> Where I can change this? I want to use more aliases.
> linux/Documentation/networking/alias.txt tells nothing about this limit
> and how to change it.
> 

I would stop using the ifconfig aliases now, and start using the iproute
(ip) command that was introduced with the 2.2 kernels.

Someone correct me if I'm wrong, but I don't think you will have trouble
with more than 16 aliases then.

Mike
