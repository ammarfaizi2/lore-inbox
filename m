Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbTLLW7o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 17:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbTLLW7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 17:59:44 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:43932 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262652AbTLLW67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 17:58:59 -0500
Date: Fri, 12 Dec 2003 23:58:56 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Increasing HZ (patch for HZ > 1000)
Message-ID: <20031212225856.GA30751@ucw.cz>
References: <F760B14C9561B941B89469F59BA3A84702C931A4@orsmsx401.jf.intel.com> <20031212223128.GA15935@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031212223128.GA15935@mail.shareable.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 10:31:28PM +0000, Jamie Lokier wrote:
> Grover, Andrew wrote:
> > I'd advocate lower HZ. Say, oh I dunno...100? This is better for power
> > management and also should make the sound go away.
> 
> Alas, the sound my Toshiba laptop makes when the CPU is busy is the
> same frequency whatever kernel, and by extension whatever the timer
> frequency.  I guess it must have another cause :/
> 
> -- Jamie

If it's when the CPU is busy, then it's the CPU's DC/DC converter. There
is no way to get rid of the noise without mnodifying the notebook.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
