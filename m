Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266297AbTAWWpE>; Thu, 23 Jan 2003 17:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266367AbTAWWpE>; Thu, 23 Jan 2003 17:45:04 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:5511 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266297AbTAWWpD> convert rfc822-to-8bit;
	Thu, 23 Jan 2003 17:45:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: Linux Geek <bourne@ToughGuy.net>, linux-kernel@vger.kernel.org
Subject: Re: using /proc/profile ??
Date: Thu, 23 Jan 2003 14:53:04 -0800
User-Agent: KMail/1.4.3
References: <3E2FDED8.3000309@ToughGuy.net>
In-Reply-To: <3E2FDED8.3000309@ToughGuy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301231453.04894.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 January 2003 04:23 am, Linux Geek wrote:
> Hi all,
>
> I've booted my linux with commandline profile=2. /proc/profile was
> created but i am not getting any meaningful info
> when i run 'readprofile' . ( with correct arguments ).
>
> The output i get is just 2 lines which shows '_stext' and then 'total'.
>
> Am i missing anything else ?
>
> TIA
>
> -

Hmmm....   I think that readprofile isn't using the right System.map.  When 
that happens to me, I've usually forgotten to update the symlink.  The 
default map file used is either  /usr/src/linux/System.map  or 
/boot/System.map

Quick check:   readprofile -m /boot/system.map_for_my_kernel
If that is the problem, this should print some useful results.

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

