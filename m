Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752900AbWKGVDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900AbWKGVDQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 16:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752809AbWKGVDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 16:03:16 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:37583 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1752901AbWKGVDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 16:03:15 -0500
Date: Tue, 7 Nov 2006 14:03:13 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Aaron Durbin <adurbin@google.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Jeff Chua <jeff.chua.linux@gmail.com>, discuss@x86-64.org
Subject: Re: [PATCH] Update MMCONFIG resource insertion to check against e820 map.
Message-ID: <20061107210313.GB27140@parisc-linux.org>
References: <8f95bb250611071249i6cf92b98p99d4b08275de6656@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f95bb250611071249i6cf92b98p99d4b08275de6656@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2006 at 12:49:53PM -0800, Aaron Durbin wrote:
> Check to see if MMCONFIG region is marked as reserved in the e820 map before
> arch/x86_64/pci/mmconfig.c |   76 
> ++++++++++++++++++++++++++++++++++++++------
> 1 files changed, 65 insertions(+), 11 deletions(-)

We'll need this for arch/i386 too ...
