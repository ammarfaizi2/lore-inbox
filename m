Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWA2QGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWA2QGu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 11:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWA2QGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 11:06:50 -0500
Received: from peabody.ximian.com ([130.57.169.10]:50924 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1751047AbWA2QGu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 11:06:50 -0500
Subject: Re: 2.6.16 - sys_sched_getaffinity & hotplug
From: Robert Love <rml@novell.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, steiner@sgi.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060129130142.GA20386@elte.hu>
References: <20060127230659.GA4752@sgi.com>
	 <20060127191400.aacb8539.pj@sgi.com> <20060128133244.GA22704@elte.hu>
	 <20060128120946.648bcf6a.pj@sgi.com> <1138481423.32314.35.camel@phantasy>
	 <20060129130142.GA20386@elte.hu>
Content-Type: text/plain
Date: Sun, 29 Jan 2006 11:09:44 -0500
Message-Id: <1138550984.32314.57.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-29 at 14:01 +0100, Ingo Molnar wrote:

> ah, indeed, so *you* are the one to be blamed for passing on a mortally 
> flawed hack, making you guilty of contributory enkludgement of the 2.6 
> kernel ;)

To be fair, I should point out that my original patch made the second
argument a pointer, so that the kernel could return the actual length of
the mask if it were too small.  This would move the interface from
"flawed hack" to "not too bad".  ;-)

Anyhow, Linus said that the interface was stupid and the second
parameter should not be a pointer.  So, if we are gonna blame
someone... :)

	Robert Love


