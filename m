Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbULHAg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbULHAg5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 19:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbULHAg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 19:36:56 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:52638 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S261963AbULHAgz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 19:36:55 -0500
Date: Wed, 8 Dec 2004 01:36:51 +0100
From: Lukas Hejtmanek <xhejtman@hell.sks3.muni.cz>
To: Nathan Scott <nathans@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041208003650.GA12775@mail.muni.cz>
References: <20041121014350.GJ4999@zaphods.net> <20041121024226.GK4999@zaphods.net> <20041202195422.GA20771@mail.muni.cz> <20041202122546.59ff814f.akpm@osdl.org> <20041202210348.GD20771@mail.muni.cz> <20041202223146.GA31508@zaphods.net> <20041202145610.49e27b49.akpm@osdl.org> <20041203061835.GF1228@frodo> <20041207111736.GA10872@mail.muni.cz> <20041208001518.GB1611@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041208001518.GB1611@frodo>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 11:15:18AM +1100, Nathan Scott wrote:
> Hmmm, thats not healthy -- the patch might be making some other
> lurking problem more likely to hit; what workload are you using
> to hit this?  (is it reproducible?)  I haven't come across this
> in the testing I've done so far, so I'm keen to try your case.

IBP server tried to recover disk allocations. That means 1 thread is reading
many files. One by one.

It did only once as I did not want to loose data I rather switched to previous
version of the kernel immediatelly.

[removed unnecessary cc]

-- 
Luká¹ Hejtmánek
