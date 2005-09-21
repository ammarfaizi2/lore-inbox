Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbVIUIRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVIUIRM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 04:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbVIUIRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 04:17:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23235 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750763AbVIUIRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 04:17:11 -0400
To: stephen.pollei@gmail.com
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Nikita Danilov <nikita@clusterfs.com>,
       Denis Vlasenko <vda@ilport.com.ua>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <nikita@clusterfs.com>
	<17197.15183.235861.655720@gargle.gargle.HOWL>
	<200509192316.j8JNFxY8030819@inti.inf.utfsm.cl>
	<feed8cdd0509192057e1aa9e3@mail.gmail.com>
	<or4q8fvd6r.fsf@livre.oliva.athome.lsd.ic.unicamp.br>
	<feed8cdd050920155714510453@mail.gmail.com>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: Wed, 21 Sep 2005 05:15:30 -0300
In-Reply-To: <feed8cdd050920155714510453@mail.gmail.com> (Stephen Pollei's
 message of "Tue, 20 Sep 2005 15:57:31 -0700")
Message-ID: <or1x3i3kgt.fsf@livre.oliva.athome.lsd.ic.unicamp.br>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 20, 2005, Stephen Pollei <stephen.pollei@gmail.com> wrote:

> it takes gcc -Wall test_proto.c --std=c99 -pedantic-errors to cause it
> not to create the a.out .
> So gcc should have caused an error as I didn't set --std=gnu99 .. bad compiler.
> So I don't know howto get gcc to follow the standards in this area,
> that sounds like a good thing to require.

gnu99 is the default.  Also, the standard doesn't talk about errors or
warnings, it only requires diagnostics for ill-formed code.  Deciding
what kind of diagnostic to issue is a compiler implementation
decision.

-- 
Alexandre Oliva         http://www.lsd.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
