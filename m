Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVEQTao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVEQTao (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 15:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVEQTan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 15:30:43 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:40625 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261444AbVEQTaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 15:30:22 -0400
Subject: Re: ALSA make menuconfig Help description missing
From: Lee Revell <rlrevell@joe-job.com>
To: Karel Kulhavy <clock@twibright.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050517145931.GA11564@kestrel>
References: <20050517123549.GA2378@kestrel> <s5hfywmotdd.wl@alsa2.suse.de>
	 <20050517145931.GA11564@kestrel>
Content-Type: text/plain
Date: Tue, 17 May 2005 15:30:16 -0400
Message-Id: <1116358216.32062.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-17 at 16:59 +0200, Karel Kulhavy wrote:
> Yes, tried, fixes ;-)
> 
> However I suggest that a pointer to user documentation for ALSA be added
> to the Help.
> 
> For example I have a problem when I run XMMS, Skype says something like
> "can't open /dev/dsp" and don't know where to start.  The only thing I
> know is that 1) I have ALSA turned on and 2) I want to know how to make
> it accept more data streams from the programs and mix them together.

There is no official user level documentation for dmix (which runs in
userspace anyway), because it was not intended to be configured by the
end user.  The current ALSA version, 1.0.9-rcX, uses dmix by default.

It's always a pain to get OSS apps to play nice with dmix, which is why
the real solution is to get proper ALSA support in Skype.

Lee



