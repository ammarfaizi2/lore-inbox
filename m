Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTKKLtC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 06:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263464AbTKKLtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 06:49:02 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:43532 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S263462AbTKKLtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 06:49:00 -0500
Date: Tue, 11 Nov 2003 12:46:49 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Flavio Bruno Leitner <fbl@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE disk information changed from 2.4 to 2.6
Message-ID: <20031111114649.GA16163@win.tue.nl>
References: <20031105172310.GE5304@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031105172310.GE5304@conectiva.com.br>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 05, 2003 at 03:23:10PM -0200, Flavio Bruno Leitner wrote:

> Upgrading from kernel 2.4 to 2.6 the CHS information for the same hardware 
> changed. This behaviour is correct? 
> 
> Using 2.4:
> hda: 12594960 sectors (6449 MB) w/2048KiB Cache, CHS=784/255/63, UDMA (33)
> 
> Using 2.6:
> hda: 12594960 sectors (6449 MB) w/2048KiB Cache, CHS=13328/15/63, UDMA (33)

Yes, correct in the sense that it is not wrong.
Probably your disk reports 15 and 2.4 invented 255.

CHS is something that stopped being meaningful a decade ago.
Today it is random garbage, to be ignored whenever possible.
Don't worry about CHS when you don't have problems.

