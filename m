Return-Path: <linux-kernel-owner+willy=40w.ods.org-S282418AbUKARja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S282418AbUKARja (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 12:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S282413AbUKARj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 12:39:28 -0500
Received: from holomorphy.com ([207.189.100.168]:2184 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S282372AbUKARjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 12:39:13 -0500
Date: Mon, 1 Nov 2004 09:39:05 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Akinobu Mita <amgta@yacht.ocn.ne.jp>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: subj: [PATHC] user-defined profiling
Message-ID: <20041101173905.GM2583@holomorphy.com>
References: <200411020133.53562.amgta@yacht.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411020133.53562.amgta@yacht.ocn.ne.jp>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 01:33:53AM +0900, Akinobu Mita wrote:
> This patch provides support for user-defined profiling. It is
> inspired by scheduler profiling.
> If you put the following code into interesting function
> 	profile_hit(USR_PROFILNG, __buildin_return_address(0));
> and boot with profile=user then the readprofile shows which functions
> called it, and how many times.
> Furthermore I much prefer to insert the user-defined profile point
> with Kprobe. This is why the profile_hits() was exported.
> Please apply.
> Signed-off-by Akinobu Mita <amgta@yacht.ocn.ne.jp>

It makes sense, though I wouldn't mind getting a look at who calls this.
Looking at the callee in isolation leaves me vaguely puzzled.


-- wli
