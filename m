Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263447AbTCNTdQ>; Fri, 14 Mar 2003 14:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263453AbTCNTdQ>; Fri, 14 Mar 2003 14:33:16 -0500
Received: from terminus.zytor.com ([63.209.29.3]:21714 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S263447AbTCNTdP>; Fri, 14 Mar 2003 14:33:15 -0500
Message-ID: <3E7230D2.7010309@zytor.com>
Date: Fri, 14 Mar 2003 11:43:14 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: linux-kernel@vger.kernel.org, kai@tp1.ruhr-uni-bochum.de
Subject: Re: Kernel setup() and initrd problems
References: <Pine.GHP.4.53.0303130942100.16619@alderaan.science-computing.de> <Pine.LNX.4.44.0303131051160.7342-100000@chaos.physics.uiowa.edu> <b4t9i6$eon$1@cesium.transmeta.com> <3E722D31.6050702@nortelnetworks.com>
In-Reply-To: <3E722D31.6050702@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> 
> Below is the script that I used to pivot from a standard ramdisk (for with
> the infrastructure is already in place in our build environment) to a tmpfs
> filesystem.  This requires no changes to the boot args.
> 
> This script runs as /sbin/init, sets up the tmpfs filesystem, pivots, and
> hands off control to the real init program.
> 

... which means that you either have boot args or rdev so that /dev/ram0 
is the root filesystem (or it wouldn't work.)

	-hpa


