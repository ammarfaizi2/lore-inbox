Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264883AbSLQKpW>; Tue, 17 Dec 2002 05:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264885AbSLQKpW>; Tue, 17 Dec 2002 05:45:22 -0500
Received: from angband.namesys.com ([212.16.7.85]:17283 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S264883AbSLQKpV>; Tue, 17 Dec 2002 05:45:21 -0500
Date: Tue, 17 Dec 2002 13:53:13 +0300
From: Oleg Drokin <green@namesys.com>
To: Chris Mason <mason@suse.com>
Cc: Andrew Morton <akpm@digeo.com>, Hans Reiser <reiser@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK][PATCH] ReiserFS CPU and memory bandwidth efficient large writes
Message-ID: <20021217135313.A17241@namesys.com>
References: <3DFA2D4F.3010301@namesys.com> <3DFA53DA.DE6788C1@digeo.com> <20021214162108.A3452@namesys.com> <3DFB7B9E.FC404B6B@digeo.com> <20021214222053.A10506@namesys.com> <3DFB904F.2ADDE2D4@digeo.com> <20021214232520.A10786@namesys.com> <1040063068.17501.31.camel@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1040063068.17501.31.camel@tiny>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Dec 16, 2002 at 01:24:28PM -0500, Chris Mason wrote:

> > reiserfs v3  was traditionally hungry on stack space I think.
> Well, if you want to drop stack usage, kill some inlines from stree.c. 
> I really doubt we gain anything from inlining these:

I must be missing something, but I always thought that by inlining stuff we
actually _decrease_ stack usage, because no need to create one more stackframe
for function call, no need to put arguments on stack and this kind of stuff.

Bye,
    Oleg
