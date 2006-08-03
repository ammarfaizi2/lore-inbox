Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWHCQk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWHCQk4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 12:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbWHCQk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 12:40:56 -0400
Received: from hera.kernel.org ([140.211.167.34]:25741 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S964849AbWHCQkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 12:40:55 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: sk98lin extremely slow transfer rate ASUS P5P800(2.6.17.7)
Date: Thu, 3 Aug 2006 09:40:09 -0700
Organization: OSDL
Message-ID: <20060803094009.5f027226@localhost.localdomain>
References: <1154619601.6485.15.camel@home-desk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1154623209 32758 10.8.0.54 (3 Aug 2006 16:40:09 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Thu, 3 Aug 2006 16:40:09 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.1.0 (GTK+ 2.8.18; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Aug 2006 08:40:01 -0700
Sean Bruno <sean.bruno@dsl-only.net> wrote:

> I am experiencing a very slow(32Kbytes per second) transfer rate on an
> ASUS P5P800 mobo.  This occurs on a special case where I am sending
> individual 32Kbyte messages from a second server.  
> 
> I suspect the hardware, but am not sure how to come up with a 'good'
> regression test for this issue.  
> 
> Configurations I have tried:
> 
> 1. If I swap out the ethernet adapter(tried a intel 10/100 and intel
> 10/100/1000) the transfer rate jumps up into the MBytes / second.
> 
> 2. If I do 'other' network activity on the box, like scp'ing' files
> around, the transfer rate for my 32Kbyte packets goes up into the
> Mbytes / second.  So I am a little baffled with the behavior.  
> 
> 3. If I just 'scp' files around of various sizes the transfer rate goes
> up into the Mbytes / second.
> 

Which driver skge or sk98lin are you using?  Sk98lin driver is being
obsoleted.
