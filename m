Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267314AbUHXTyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267314AbUHXTyi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 15:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268246AbUHXTyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 15:54:38 -0400
Received: from mail.enyo.de ([212.9.189.167]:52490 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S267314AbUHXTyg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 15:54:36 -0400
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc1
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
	<20040824184245.GE5414@waste.org>
	<Pine.LNX.4.58.0408241221390.17766@ppc970.osdl.org>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Tue, 24 Aug 2004 21:54:33 +0200
In-Reply-To: <Pine.LNX.4.58.0408241221390.17766@ppc970.osdl.org> (Linus
	Torvalds's message of "Tue, 24 Aug 2004 12:23:42 -0700 (PDT)")
Message-ID: <871xhwb9c6.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds:

> On Tue, 24 Aug 2004, Matt Mackall wrote:
>> 
>> Phew, I was worried about that. Can I get a ruling on how you intend
>> to handle a x.y.z.1 to x.y.z.2 transition? I've got a tool that I'm
>> looking to unbreak. My preference would be for all x.y.z.n patches to
>> be relative to x.y.z.
>
> Hmm.. I have no strong preferences. There _is_ obviously a well-defined 
> ordering from x.y.z.1 -> x.y.z.2 (unlike the -rcX releases that don't have 
> any ordering wrt the bugfixes), so either interdiffs or whole new full 
> diffs are totally "logical". We just have to chose one way or the other, 
> and I don't actually much care.

It would be slightly more consistent to diff .2 against .1 because
this is what already happens when a new x.y.z release is published.
