Return-Path: <linux-kernel-owner+w=401wt.eu-S1750791AbXAIAdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbXAIAdY (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 19:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbXAIAdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 19:33:24 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:54299 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbXAIAdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 19:33:23 -0500
Date: Mon, 8 Jan 2007 19:33:18 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/24] Unionfs: Documentation
Message-ID: <20070109003230.GD5418@filer.fsl.cs.sunysb.edu>
References: <20070108111852.ee156a90.akpm@osdl.org> <200701082051.l08KpV8b011212@agora.fsl.cs.sunysb.edu> <1pw35070vgjt0.vkrm8bjemedb$.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1pw35070vgjt0.vkrm8bjemedb$.dlg@40tude.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 01:19:48AM +0100, Giuseppe Bilotta wrote:
> As a simple user without much knowledge of kernel internals, much less
> so filesystems, couldn't something based on the same principle of
> lsof+fam be used to handle these situations?

Using inotify has been suggested before. That let the upper filesystem
know when something changed on the lower filesystem.

I think that, while it would work, it is not the right solution.

Josef "Jeff" Sipek.

-- 
Intellectuals solve problems; geniuses prevent them
		- Albert Einstein
