Return-Path: <linux-kernel-owner+w=401wt.eu-S1750857AbXAIB2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbXAIB2Y (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 20:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbXAIB2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 20:28:24 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:60836 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857AbXAIB2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 20:28:23 -0500
Date: Tue, 9 Jan 2007 02:26:45 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
cc: Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/24] Unionfs: Documentation
In-Reply-To: <20070109003230.GD5418@filer.fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0701090226340.20773@yvahk01.tjqt.qr>
References: <20070108111852.ee156a90.akpm@osdl.org>
 <200701082051.l08KpV8b011212@agora.fsl.cs.sunysb.edu>
 <1pw35070vgjt0.vkrm8bjemedb$.dlg@40tude.net> <20070109003230.GD5418@filer.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 8 2007 19:33, Josef Sipek wrote:
>On Tue, Jan 09, 2007 at 01:19:48AM +0100, Giuseppe Bilotta wrote:
>> As a simple user without much knowledge of kernel internals, much less
>> so filesystems, couldn't something based on the same principle of
>> lsof+fam be used to handle these situations?
>
>Using inotify has been suggested before. That let the upper filesystem
>know when something changed on the lower filesystem.
>
>I think that, while it would work, it is not the right solution.

Because inotify is not recursive yet?


	-`J'
-- 
