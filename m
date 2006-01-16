Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWAPQPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWAPQPT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 11:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWAPQPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 11:15:19 -0500
Received: from smtpout.mac.com ([17.250.248.72]:33746 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750723AbWAPQPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 11:15:18 -0500
In-Reply-To: <20060116155353.GC18972@csclub.uwaterloo.ca>
References: <20060113144529.56fa3166@darjeeling.triplehelix.org> <20060116155353.GC18972@csclub.uwaterloo.ca>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <631F1A6F-EA27-4CDC-8D23-C7C6467FB28B@mac.com>
Cc: Joshua Kwan <joshk@triplehelix.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [?] PCI BIOS masks some IDs to prevent OS detection?
Date: Mon, 16 Jan 2006 11:15:12 -0500
To: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 16, 2006, at 10:53, Lennart Sorensen wrote:
> Maybe the raid card has a pin shorted to ground, so all reads of  
> that bit read as 0.  That would explain why all the cards lost the  
> same bit. It appears to be the highest bit on the bus that is stuck  
> low.
>
> I see this fairly frequently on our own mainboards due to a problem  
> with the soldering of a surface mount pci bridge chip on the bottom  
> of the board.

I've also seen this problem with a faulty case where a small metal  
support shorted a couple pins on the PCI riser.  It gave odd PCI ids,  
corrupted data, and crashed within a minute of booting.  After  
removing the metal bracket, it's been stable for almost a year.

Cheers,
Kyle Moffett

--
I have yet to see any problem, however complicated, which, when you  
looked at it in the right way, did not become still more complicated.
   -- Poul Anderson



