Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311918AbSCODDW>; Thu, 14 Mar 2002 22:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311917AbSCODDM>; Thu, 14 Mar 2002 22:03:12 -0500
Received: from rj.sgi.com ([204.94.215.100]:35529 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S311933AbSCODDC>;
	Thu, 14 Mar 2002 22:03:02 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VGA blank causes hang with 2.4.18 
In-Reply-To: Your message of "Thu, 14 Mar 2002 19:52:31 PDT."
             <200203150252.g2F2qVM15051@vindaloo.ras.ucalgary.ca> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 15 Mar 2002 14:02:46 +1100
Message-ID: <8380.1016161366@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2002 19:52:31 -0700, 
Richard Gooch <rgooch@ras.ucalgary.ca> wrote:
>  Hi, all. Here's a perverse problem: when the screen blanks (text
>console) with 2.4.18, the machine hangs. No ping response, no magic
>SysReq response. I didn't have this problem with 2.4.7.
>
>The command I used to configure screen blanking was:
>setterm -blank 10 -powerdown 0
>
>This is an Athalon 850 MHz on a Gigabyte GA-7ZM motherboard.

Any response with kdb + nmi watchdog + serial console?  Sounds like a
lock problem, kdb + nmi watchdog normally lets you debug those.

