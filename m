Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312460AbSDSOGU>; Fri, 19 Apr 2002 10:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312466AbSDSOGT>; Fri, 19 Apr 2002 10:06:19 -0400
Received: from ns.suse.de ([213.95.15.193]:42245 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312460AbSDSOGS>;
	Fri, 19 Apr 2002 10:06:18 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SSE related security hole
In-Reply-To: <20020418183639.20946.qmail@science.horizon.com.suse.lists.linux.kernel> <a9ncgs$2s2$1@cesium.transmeta.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 19 Apr 2002 16:06:17 +0200
Message-ID: <p73662naili.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:
> 
> Perhaps the right thing to do is to have a description in data of the
> desired initialization state and just F[NX]RSTOR it?

Sounds like the cleanest solution. The state could be saved at CPU bootup
with just MXCSR initialized.

I'll implement that for x86-64.

-Andi
