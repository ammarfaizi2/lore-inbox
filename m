Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289328AbSBST0e>; Tue, 19 Feb 2002 14:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289347AbSBST0Y>; Tue, 19 Feb 2002 14:26:24 -0500
Received: from ns.suse.de ([213.95.15.193]:51214 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289328AbSBST0P>;
	Tue, 19 Feb 2002 14:26:15 -0500
Date: Tue, 19 Feb 2002 20:26:11 +0100
From: Dave Jones <davej@suse.de>
To: John Hughes <johughes@shaw.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.5 NVidia driver compile fails
Message-ID: <20020219202611.D11133@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	John Hughes <johughes@shaw.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <0GRS001V4NKSMU@l-daemon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <0GRS001V4NKSMU@l-daemon>; from johughes@shaw.ca on Tue, Feb 19, 2002 at 01:07:13PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2002 at 01:07:13PM -0600, John Hughes wrote:
 > nv.c:1438: incompatible type for argument 4 of `remap_page_range_Reb32c755'
 > nv.c:1438: too few arguments to function `remap_page_range_Reb32c755'
 > make[2]: *** [nv.o] Error 1

 Assuming you get lucky, and manage to fix up all the compile
 errors in the source you have, chances are that the same
 interface changes will break the binary only part too.
 So it'll compile, link, and likely explode as soon as you
 try to use it.

 It's likely that only nvidia can help you here.
 Same goes for any other binary only module during a devel series.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
