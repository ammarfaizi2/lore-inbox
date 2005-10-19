Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbVJSSnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbVJSSnM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 14:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVJSSnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 14:43:12 -0400
Received: from smtpout.mac.com ([17.250.248.85]:32510 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751215AbVJSSnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 14:43:11 -0400
In-Reply-To: <200510191958.37542.gfiala@s.netic.de>
References: <200510182201.11241.gfiala@s.netic.de> <1129695001.8910.57.camel@mindpipe> <200510191958.37542.gfiala@s.netic.de>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3370794E-8B47-4342-8383-C2B0F77192B3@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: large files unnecessary trashing filesystem cache?
Date: Wed, 19 Oct 2005 14:43:06 -0400
To: Guido Fiala <gfiala@s.netic.de>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 19, 2005, at 13:58:37, Guido Fiala wrote:
> Kernel could do the best to optimize default performance,  
> applications that consider their own optimal behaviour should do  
> so, all other files are kept under default heuristic policy  
> (adaptable, configurable one)
>
> Heuristic can be based on access statistic:
>
> streaming/sequential can be guessed by getting exactly 100% cache  
> hit rate (drop behind pages immediately),

What about a grep through my kernel sources or other linear search  
through a large directory tree?  That would get exactly 100% cache  
hit rate which would cause your method to drop the pages immediately,  
meaning that subsequent greps are equally slow.  I have enough memory  
to hold a couple kernel trees and I want my grepping to push OO.org  
out of RAM for a bit while I do my kernel development.


Cheers,
Kyle Moffett

--
I lost interest in "blade servers" when I found they didn't throw  
knives at people who weren't supposed to be in your machine room.
   -- Anthony de Boer


