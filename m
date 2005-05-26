Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVEZSBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVEZSBZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 14:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVEZSBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 14:01:24 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:48590 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261670AbVEZSBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 14:01:13 -0400
Subject: Re: 2.6.12-rc5-mm1 alsa oops
From: Lee Revell <rlrevell@joe-job.com>
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: pharon@gmail.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200505261944.50942.petkov@uni-muenster.de>
References: <1117092768.26173.4.camel@localhost>
	 <200505261944.50942.petkov@uni-muenster.de>
Content-Type: text/plain
Date: Thu, 26 May 2005 14:01:09 -0400
Message-Id: <1117130470.5477.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-26 at 19:44 +0200, Borislav Petkov wrote:
> <snip>
> 
> Andrew,
> 
> similar oopses as the one I'm replying to all over the place. At it happens m 
> in snd_pcm_mmap_data_close(). Here's a stack trace:

No one using ALSA CVS or any of the 1.0.9 release candidates ever
reported this, but lots of -mm users are... does that help at all?  I
suspect some upstream bug that ALSA just happens to trigger.

Lee

