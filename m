Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264048AbUEXGAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264048AbUEXGAP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 02:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264057AbUEXGAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 02:00:15 -0400
Received: from holomorphy.com ([207.189.100.168]:31111 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264048AbUEXGAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 02:00:11 -0400
Date: Sun, 23 May 2004 23:00:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Cef (LKML)" <cef-lkml@optusnet.com.au>
Cc: linux-kernel@vger.kernel.org, "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [announce/OT] kerneltop ver. 0.7
Message-ID: <20040524060007.GN1833@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Cef (LKML)" <cef-lkml@optusnet.com.au>,
	linux-kernel@vger.kernel.org, "Randy.Dunlap" <rddunlap@osdl.org>
References: <20040523215027.5dc99711.rddunlap@osdl.org> <200405241553.44114.cef-lkml@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405241553.44114.cef-lkml@optusnet.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2004 at 03:53:42PM +1000, Cef (LKML) wrote:
> Looks good! A few suggestions....
> Might want to add support for /boot/System.map containing the version number 
> (eg: /boot/System.map-`uname -r` ), if /boot/System.map doesn't exist, before 
> just dropping out with an error.
> For clarity, you might want to invert the "address  function ....." line to 
> separate the header from the actual displayed data (like top does).
> Having the total up in the header instead of at the end of the data might also 
> be useful (eg: next to ticks perhaps?) as it's really a waste of a display 
> line for 1 number.
> Also a little more verbosity in the error messages would be good. 
> eg:
>  /proc/profile not found:
>  You need to enable profiling support in your kernel to use kerneltop
>  /proc/profile Permission Denied:
>  You need to be root to run kerneltop
> Hope these comments are useful.

Please try the patch I just posted which eliminates the need to be root.


-- wli
