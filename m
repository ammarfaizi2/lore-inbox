Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965010AbWHWP5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbWHWP5x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 11:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbWHWP5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 11:57:53 -0400
Received: from 81-179-62-49.dsl.pipex.com ([81.179.62.49]:53735 "EHLO
	jaguar.linux-grotto.org.uk") by vger.kernel.org with ESMTP
	id S965010AbWHWP5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 11:57:52 -0400
Message-ID: <44EC7AFD.2070605@linux-grotto.org.uk>
Date: Wed, 23 Aug 2006 16:57:49 +0100
From: Johan Groth <johan.groth@linux-grotto.org.uk>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Scsi errors with Megaraid 300-8x
References: <44EB1875.3020403@linux-grotto.org.uk> <44EC73D2.9090302@rtr.ca> <44EC775C.7040003@linux-grotto.org.uk> <Pine.LNX.4.64.0608231145290.15031@p34.internal.lan> <44EC78CD.9010401@linux-grotto.org.uk> <Pine.LNX.4.64.0608231153130.15031@p34.internal.lan>
In-Reply-To: <Pine.LNX.4.64.0608231153130.15031@p34.internal.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> 
> Nope, r+w will write over everything on the disk, but I have found -the- 
> most effective way to see if a disk is good or not.  I'd rather have the 
> disk die to that test rather than using it in production and finding it 
> dies with my data on it.
> 

Hmm, we both should read the man page of badblocks a bit better :).
I found this:

-n     Use non-destructive read-write mode.  By default only a 
non-destructive read-only test is done. This option must not be combined 
with the -w option, as they are mutually exclusive.


Cheers,
Johan
