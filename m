Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280808AbRKTAjK>; Mon, 19 Nov 2001 19:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280805AbRKTAjA>; Mon, 19 Nov 2001 19:39:00 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:24332 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S280804AbRKTAiw>;
	Mon, 19 Nov 2001 19:38:52 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200111200038.fAK0cdj152284@saturn.cs.uml.edu>
Subject: Re: x bit for dirs: misfeature?
To: vda@port.imtp.ilyichevsk.odessa.ua (vda)
Date: Mon, 19 Nov 2001 19:38:39 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01111916225301.00817@nemo> from "vda" at Nov 19, 2001 04:22:53 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vda writes:

> I think "Whatta hell with this x bit meaning 'can browse'
> for dirs?! Who was that clever guy who invented that? Grrrr"
>
> Isn't r sufficient? Can we deprecate x for dirs?
> I.e. make it a mirror of r: you set r, you see x set,
> you clear r, you see x cleared, set/clear x = nop?

That won't fly, but maybe NFSv4 permissions will. Then at
least you could specify "search" or "traverse" permission,
neither of which will affect regular files.
