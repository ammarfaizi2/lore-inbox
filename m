Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbTESVzG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 17:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263025AbTESVzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 17:55:06 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:30592
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261790AbTESVzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 17:55:05 -0400
Date: Mon, 19 May 2003 17:57:48 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: mikpe@csd.uu.se
cc: alexander.riesen@synopsys.COM, "" <sfr@canb.auug.org.au>,
       "" <linux-kernel@vger.kernel.org>, "" <linux-laptop@vger.kernel.org>
Subject: Re: 2.5.69+bk: oops in apmd after waking up from suspend mode
In-Reply-To: <200305191216.h4JCGONj015081@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.50.0305190840080.28750-100000@montezuma.mastecende.com>
References: <200305191216.h4JCGONj015081@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 May 2003 mikpe@csd.uu.se wrote:

> As to _why_ kapmd's current->mm is NULL, I don't know. It isn't
> when I test APM suspend in 2.5.69-bk. A lot of code dereferences
> current->mm without checking, so I guess current->mm==NULL is a bug.

For kernel threads (as is the case with kapmd) current->mm would be NULL.

	Zwane

-- 
function.linuxpower.ca
