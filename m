Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262544AbVAJVEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbVAJVEd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 16:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbVAJUgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 15:36:04 -0500
Received: from gprs214-40.eurotel.cz ([160.218.214.40]:896 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262514AbVAJUfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 15:35:39 -0500
Date: Mon, 10 Jan 2005 21:24:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alex LIU <alex.liu@st.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The purpose of PT_TRACESYSGOOD
Message-ID: <20050110202427.GA1358@elf.ucw.cz>
References: <005c01c4f6c8$b4d3fba0$ac655e0a@sha.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005c01c4f6c8$b4d3fba0$ac655e0a@sha.st.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> What's the effect of PT_TRACESYSGOOD flag? I found it's used only set in ptrace_setoptions,which is called in the function ptrace_request. And the PT_TRACESYSGOOD flag will be requested in do_syscall_trace. What's the purpose of that flag? Thanks! 
> 

Search archives, it was needed for subterfugue.
										Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
