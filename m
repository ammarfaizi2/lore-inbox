Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261524AbSKNDVO>; Wed, 13 Nov 2002 22:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbSKNDTN>; Wed, 13 Nov 2002 22:19:13 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:22287
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261418AbSKNDSW>; Wed, 13 Nov 2002 22:18:22 -0500
Date: Wed, 13 Nov 2002 22:18:59 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] Remove BUG in cpu_up 
In-Reply-To: <20021114013718.0FA082C243@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0211132217580.24523-100000@montezuma.mastecende.com>
X-Operating-System: Linux 2.4.19-pre5-ac3-zm4
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2002, Rusty Russell wrote:

> It is bloody convoluted.  Hmm, the arch needs to wait before returning
> "success" on __cpu_up.

What if the processor never comes up? Whats wrong with doing this async?

	Zwane
-- 
function.linuxpower.ca

