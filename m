Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318795AbSH1Mkh>; Wed, 28 Aug 2002 08:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318796AbSH1Mkh>; Wed, 28 Aug 2002 08:40:37 -0400
Received: from kiruna.synopsys.com ([204.176.20.18]:53893 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S318795AbSH1Mkg>; Wed, 28 Aug 2002 08:40:36 -0400
Date: Wed, 28 Aug 2002 14:44:43 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Georg Demme <gdemme@graphics.cs.uni-sb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Server Hangups
Message-ID: <20020828124443.GD16092@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Georg Demme <gdemme@graphics.cs.uni-sb.de>,
	linux-kernel@vger.kernel.org
References: <200208281049.g7SAnFX7004638@pixel.cs.uni-sb.de> <20020828111240.GC16092@riesen-pc.gr05.synopsys.com> <200208281235.g7SCZZ9H001715@pixel.cs.uni-sb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208281235.g7SCZZ9H001715@pixel.cs.uni-sb.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 02:35:35PM +0200, Georg Demme wrote:
> Hi
> 
> > syslog, dmesg output would be useful
> > 
> Aug 27 19:48:16 graphics kernel: nvidia: loading NVIDIA NVdriver Kernel Module  1.0-2960  Tue May 14 07:41:42 PDT 2002
> Aug 27 19:48:16 graphics kernel: devfs_register(nvidiactl): could not append to parent, err: -17
> Aug 27 19:48:16 graphics kernel: devfs_register(nvidia0): could not append to parent, err: -17

try to reproduce the problem without loading nvidia drivers.
If it's a server, why do you load the nvdriver at all?

-alex
