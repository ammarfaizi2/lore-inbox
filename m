Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310217AbSCBA0z>; Fri, 1 Mar 2002 19:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310219AbSCBA0j>; Fri, 1 Mar 2002 19:26:39 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:2714 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S310217AbSCBAZz>; Fri, 1 Mar 2002 19:25:55 -0500
Date: Fri, 1 Mar 2002 17:40:07 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: hpa@zytor.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Device Number assignment for NetWare Devices
Message-ID: <20020301174007.A12861@vger.timpanogas.org>
In-Reply-To: <20020301173904.A12835@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020301173904.A12835@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Fri, Mar 01, 2002 at 05:39:04PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 05:39:04PM -0700, Jeff V. Merkey wrote:
> 
> 
> Peter,
> 
> I need a major number for NetWare volumes.  In the new NWFS model,
> I am now mapping nwfs stripped and mirrored volumes beneath 
> the buffer cache as devices (the way it should have been to start
> with) and I am using Linus' buffer cache for NWFS rather than 
> my own.
> 
> To do this, I have been using the experimental ranges, but for 
> posting the code, I need an assigned one.  Is there a major number
> available I can use for block devices.
> 
> Info provided:
> 
> block device
> 
> /dev/nwd0
> /dev/nwd1
> /dev/nwd.. etc.

I will use the same block address for M2FS clustered volumes that
run over SCI. 

:-)

Jeff

> 
> major device (Peter Assigns) minor numbers 0-255
> for a total of 256 local NetWare volumes.  On native NetWare,
> 256 is the limit per server for the number of local volumes
> available.
> 
> Thanks,
> 
> Respectfully Submitted,
> 
> :-)
> 
> Jeff
> 
> 
