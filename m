Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbUBWGAT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 01:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbUBWGAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 01:00:19 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:53462 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S261827AbUBWGAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 01:00:14 -0500
Date: Sun, 22 Feb 2004 21:59:52 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Gordon Stanton <coder101@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: large built-in.o
Message-ID: <20040223055952.GJ18563@srv-lnx2600.matchmail.com>
Mail-Followup-To: Gordon Stanton <coder101@linuxmail.org>,
	linux-kernel@vger.kernel.org
References: <20040223055328.D70BB23947@ws5-3.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040223055328.D70BB23947@ws5-3.us4.outblaze.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 01:53:28PM +0800, Gordon Stanton wrote:
> Hi,
>   Just a quick question. I was building 2.6.3 with allyesconfig and I noticed it was making many built-in.o files around the place. These are quite large object files
> Eg. in fs is 
> 74992735 Feb 23 15:35 built-in.o
>   74Meg for the filesystems code and thats with even the individual .o files compiled with -Os
> 
>   I haven't noticed this happening before. Is it new for 2.6.x?

Turn off CONFIG_DEBUG_INFO
