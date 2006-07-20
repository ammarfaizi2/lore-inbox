Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbWGTAId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbWGTAId (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 20:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWGTAId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 20:08:33 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:20105 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S964877AbWGTAIc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 20:08:32 -0400
Message-ID: <1153354106.44bec97a1215b@portal.student.luth.se>
Date: Thu, 20 Jul 2006 02:08:26 +0200
From: ricknu-0@student.ltu.se
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] A generic boolean
References: <1153341500.44be983ca1407@portal.student.luth.se> <20060719212049.GA6828@martell.zuzino.mipt.ru> <1153349221.44beb6653e039@portal.student.luth.se> <44BEC5DA.4020807@bigpond.net.au>
In-Reply-To: <44BEC5DA.4020807@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 130.240.42.170
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Citerar Peter Williams <pwil3058@bigpond.net.au>:

> ricknu-0@student.ltu.se wrote:
> > Citerar Alexey Dobriyan <adobriyan@gmail.com>:
> >> Please, show compiler flag[s] to enable warning[s] from gcc about
> >>
> >> 	_Bool foo = 42;
> >>
> >> Until you do that the whole activity is moot.
> > On it...
> 
> Would not the compiler treat 42 as a Boolean expression (as opposed to 
> an integer expression) that evaluates to true and set foo accordingly. 
> I.e. there's only a problem here if foo ends up with the value 42 
> instead of the value true.
Yeah, that is true. As I said, the only way (I seen) is to cast the pointer from
the boolean variable to something else and change the value on that address. But
it would be neat if the compiler said something when inserting somthing else
then (or equal to) 0 and 1.
Right now it is happy with:
_Bool a = "Hello world";


Well, better go to bed while I still remember where it is.

Good night
