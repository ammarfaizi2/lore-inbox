Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267511AbUH3I5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267511AbUH3I5F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 04:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267504AbUH3I5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 04:57:05 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:62417
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S267511AbUH3I5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 04:57:02 -0400
Message-ID: <4132EBDC.2010302@bio.ifi.lmu.de>
Date: Mon, 30 Aug 2004 10:57:00 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Karl Vogel <karl.vogel@seagha.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1+patches: Still a memory leak with cdrecord
References: <412F4637.8080901@bio.ifi.lmu.de> <412F5624.7010506@seagha.com>
In-Reply-To: <412F5624.7010506@seagha.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karl Vogel wrote:

> You can look at the kernel boot messages to find out, or do the 
> following in a shell after booting:
> 
> # dmesg|grep "io scheduler"

Yes, it's the default:

galois /root# dmesg|grep "io scheduler"
Using anticipatory io scheduler

Anyway, no one seems to have a clue on this still existing failure :-(

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

