Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274570AbRIYOim>; Tue, 25 Sep 2001 10:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274577AbRIYOie>; Tue, 25 Sep 2001 10:38:34 -0400
Received: from borg.org ([208.218.135.231]:19207 "HELO borg.org")
	by vger.kernel.org with SMTP id <S274570AbRIYOiX>;
	Tue, 25 Sep 2001 10:38:23 -0400
Date: Tue, 25 Sep 2001 10:38:48 -0400
From: Kent Borg <kentborg@borg.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-ac15: Missing symbols in kernel.o:apm()
Message-ID: <20010925103848.B27059@borg.org>
In-Reply-To: <200109242307.f8ON7A0i025305@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109242307.f8ON7A0i025305@pincoya.inf.utfsm.cl>; from vonbrand@inf.utfsm.cl on Mon, Sep 24, 2001 at 07:07:10PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2001 at 07:07:10PM -0400, Horst von Brand wrote:
> It complains about missing __sysrq_{{,un}lock_table,{get,put}_key} in
> arch/i386/kernel.o function apm on linking.

Already been reported, twice that I have seen.  Workaround is to
change you config: turn on CONFIG_MAGIC_SYSRQ under "Kernel hacking".

-kb
