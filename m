Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318663AbSHEPho>; Mon, 5 Aug 2002 11:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318666AbSHEPho>; Mon, 5 Aug 2002 11:37:44 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:2052 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S318663AbSHEPhn>; Mon, 5 Aug 2002 11:37:43 -0400
Date: Mon, 5 Aug 2002 19:41:11 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Mark Hansel <lists@hansel.mnstate.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19, Alpha (LX 164), X(?) error
Message-ID: <20020805194111.A648@jurassic.park.msu.ru>
References: <Pine.LNX.4.44.0208051013590.1828-100000@hansel.mnstate.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0208051013590.1828-100000@hansel.mnstate.edu>; from lists@hansel.mnstate.edu on Mon, Aug 05, 2002 at 10:14:16AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2002 at 10:14:16AM -0500, Mark Hansel wrote:
> Netscape failes to start with no log messages and screen output:
> 
> "XIO:  fatal IO error 22 (Invalid argument) on X server ":0.0"
>       after 117 requests (116 known processed) with 1 events remaining."

Rebuild the kernel with

CONFIG_OSF4_COMPAT=y


Ivan.
