Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268439AbUJDSEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268439AbUJDSEt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 14:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268378AbUJDSEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 14:04:44 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:32644 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S268400AbUJDSD5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 14:03:57 -0400
Date: Mon, 4 Oct 2004 14:03:56 -0400 (EDT)
From: William Knop <wknop@andrew.cmu.edu>
To: Jim Paris <jim@jtan.com>
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: libata badness
In-Reply-To: <20041004175003.GA10814@jim.sh>
Message-ID: <Pine.LNX.4.60-041.0410041353270.9105@unix43.andrew.cmu.edu>
References: <Pine.LNX.4.60-041.0410040656001.2350@unix48.andrew.cmu.edu>
 <41617AA0.9020809@pobox.com> <Pine.LNX.4.60-041.0410041323160.9105@unix43.andrew.cmu.edu>
 <20041004175003.GA10814@jim.sh>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Or else something else on your system is bad.  Like your CPU or RAM.
> Run memtest for a while.

I ran memtest for a few hours. It all checks out. Also, CPU intensive 
stuff doesn't cause weirdness.

The only things which cause corruption, so far as I can tell, are 
operations on my raid device, md0. Copying from the array takes a while 
for a crash, while rebuilding a drive on the array is very prompt (<1m) at 
causing a crash. The crashes likely as not cause widespread kernel 
corruption. It's only a matter of time before my root fs is blown away 
again.

