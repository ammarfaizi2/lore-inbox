Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbTBSVLH>; Wed, 19 Feb 2003 16:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261527AbTBSVLH>; Wed, 19 Feb 2003 16:11:07 -0500
Received: from rth.ninka.net ([216.101.162.244]:3489 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S261463AbTBSVLE>;
	Wed, 19 Feb 2003 16:11:04 -0500
Subject: Re: [PATCH] IPSec protocol application order
From: "David S. Miller" <davem@redhat.com>
To: Tom Lendacky <toml@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, "Alexey N. Kuznetsov" <kuznet@ms2.inr.ac.ru>
In-Reply-To: <1045687340.3419.14.camel@tomlt2.austin.ibm.com>
References: <1045687340.3419.14.camel@tomlt2.austin.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Feb 2003 14:05:18 -0800
Message-Id: <1045692318.14306.5.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-19 at 12:42, Tom Lendacky wrote:
> The IPSec RFC (2401) and IPComp RFC (3173) specify the order in which
> the COMP, ESP and AH protocols must be applied when being applied in
> transport mode.  Specifically, COMP must be applied first, then ESP
> and then AH.  Also, transport mode protocols must be applied before
> tunnel mode protocols.

Did you even read the email from Alexey yesterday that described
why none of this is a kernel issue and we merely do exactly what
the user application tells us to do when it uploads key configuration?

Just like you aparently ignored his email, I will ignore your patch.

