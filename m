Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292482AbSB0O30>; Wed, 27 Feb 2002 09:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292529AbSB0O3G>; Wed, 27 Feb 2002 09:29:06 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:27816 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S292482AbSB0O3A>; Wed, 27 Feb 2002 09:29:00 -0500
Date: Wed, 27 Feb 2002 15:28:56 +0100
From: bert hubert <ahu@ds9a.nl>
To: Zhu Ying Jie <zhuyingj@comp.nus.edu.sg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to disable TCP's checksum
Message-ID: <20020227152856.B18366@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Zhu Ying Jie <zhuyingj@comp.nus.edu.sg>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0202272215080.21508-100000@sf3.comp.nus.edu.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0202272215080.21508-100000@sf3.comp.nus.edu.sg>; from zhuyingj@comp.nus.edu.sg on Wed, Feb 27, 2002 at 02:20:11PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 02:20:11PM +0000, Zhu Ying Jie wrote:
> Hi,
>   I am currently using kernel version 2.4.2 and trying to disable
> tcp_input's checksum function. However, even I comment all the csum_error
> in the file tcp_input.c, the packet (with wrong checksum) seems still will
> be dropped. Can anyone tell me how to do the work? 

Perhaps the ip checksum is also incorrect?

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
