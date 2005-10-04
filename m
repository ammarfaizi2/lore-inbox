Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbVJDR7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbVJDR7n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 13:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbVJDR7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 13:59:43 -0400
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:7580 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP id S964869AbVJDR7m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 13:59:42 -0400
Date: Tue, 4 Oct 2005 19:59:39 +0200 (CEST)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 in-kernel file opening
In-Reply-To: <Pine.LNX.4.60.0510041945260.8210@kepler.fjfi.cvut.cz>
Message-ID: <Pine.LNX.4.60.0510041957590.8210@kepler.fjfi.cvut.cz>
References: <Pine.LNX.4.60.0510041924520.8210@kepler.fjfi.cvut.cz>
 <Pine.LNX.4.61.0510041329180.29678@chaos.analogic.com>
 <Pine.LNX.4.60.0510041945260.8210@kepler.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Oct 2005, Martin Drab wrote:
...
> things within the driver before the mmap() - I guess that should be 
> possibble to do from within the fops->mmap(), but I also need to do 
> something upon munmap()ping. Where should I place that? There doesn't seem 
> to be any function that would be called upon user munmap(). :(

Should this be placed at vmops->close()?

Martin

