Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbTKXNc1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 08:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263356AbTKXNc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 08:32:27 -0500
Received: from h192n2fls310o1003.telia.com ([81.224.187.192]:26516 "EHLO
	cambrant.com") by vger.kernel.org with ESMTP id S263310AbTKXNc0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 08:32:26 -0500
Date: Mon, 24 Nov 2003 14:31:20 +0100
From: tim@cambrant.com
To: Breno <brenosp@brasilsec.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Force Coredump
Message-ID: <20031124133120.GA13678@cambrant.com>
References: <001001c3b28d$183400e0$34dfa7c8@bsb.virtua.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001001c3b28d$183400e0$34dfa7c8@bsb.virtua.com.br>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 24, 2003 at 11:15:51AM -0200, Breno wrote:
> Anybody knows why ?

Perhaps you don't have writing access to the directory where the program is placed, or there is already a core file in the same directory, which you don't have writing access to. Another possibility (more likely) is that 'ulimit -c' is set too low. Try typing 'ulimit -c unlimited' and see if that works. This command will produce a core file for every segfault that occurs, which may be inconvenient, so take a note of what ulimit is set to before you change it.

Hope that helps. Good luck.

-- 
Tim Cambrant <tim@cambrant.com> 
GPG KeyID 0x59518702
Fingerprint: 14FE 03AE C2D1 072A 87D0  BC4D FA9E 02D8 5951 8702
