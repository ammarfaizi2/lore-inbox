Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268275AbUJDPws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268275AbUJDPws (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 11:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268271AbUJDPum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 11:50:42 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:33953 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S268251AbUJDPuR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 11:50:17 -0400
Date: Mon, 4 Oct 2004 11:50:13 -0400 (EDT)
From: William Knop <wknop@andrew.cmu.edu>
To: Jon Lewis <jlewis@lewis.org>
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: libata badness
In-Reply-To: <Pine.LNX.4.58.0410040953160.26615@web1.mmaero.com>
Message-ID: <Pine.LNX.4.60-041.0410041132070.9105@unix43.andrew.cmu.edu>
References: <Pine.LNX.4.60-041.0410040656001.2350@unix48.andrew.cmu.edu>
 <Pine.LNX.4.58.0410040953160.26615@web1.mmaero.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What kind of sata drives?  It's not quite the same end result, but there
> have been several posts on linux-raid about defective Maxtor sata drives
> causing system freezes.  If your drives are Maxtor, download their
> powermax utility and test your drives.  You may find that you have one or
> more marginal drives that appear to work most of the time, but powermax
> will determine are bad.  Replacing one like that fixed my problems.

Ah, well all of them are Maxtor drives... One 6y250m0 and three 7y250m0 
drives. I'm using powermax on them right now. They all passed the quick 
test, and the full test results are forthcoming.

Actually, I was backing up the array (cp from the array - 2 of 3 drives 
running - to a normal drive) when I read your response. Shortly 
thereafter, during the cp (perhaps after copying 100GB-120GB), I got a 
double fault. I've never gotten a double fault before, but I'm guessing 
it's quite a serious error. It totally locked up the machine, and it 
outputted two lines each with a double fault message, followed by a 
register dump.

The saga continues...

Will
