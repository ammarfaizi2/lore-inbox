Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266914AbUJBAvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266914AbUJBAvQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 20:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267164AbUJBAvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 20:51:16 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:41887 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266914AbUJBAvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 20:51:09 -0400
Subject: io_remap_page_range (was Re: [Alsa-devel] alsa-driver will not
	compile with kernel  2.6.9-rc2-mm4-S7)
From: Lee Revell <rlrevell@joe-job.com>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <32868.192.168.1.8.1096677269.squirrel@192.168.1.8>
References: <1096675930.27818.74.camel@krustophenia.net>
	 <32868.192.168.1.8.1096677269.squirrel@192.168.1.8>
Content-Type: text/plain
Message-Id: <1096678268.27818.84.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 01 Oct 2004 20:51:08 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-01 at 20:34, Rui Nuno Capela wrote:
> Lee Revell wrote:
> Good grief! I'm having this too, and I was desperate thinking I was the
> only one, and ultimately offering the blame to gcc 3.4.1 which is what I'm
> test-driving now on my laptop (Mdk 10.1c).
> 
> Now I remember that -mm4 has some issue about remap_page_range kernel
> symbol being renamed to something else, which is breaking the build of
> outsider modules (i.e. not the ones bundled under the kernel source tree).
> Or so it seems.

Looking through my archives I cannot find a report of this exact issue,
but you are probably right.  Looks like ALSA drivers need to be updated.

Lee

