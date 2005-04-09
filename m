Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVDIWM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVDIWM6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 18:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVDIWM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 18:12:58 -0400
Received: from mail.enyo.de ([212.9.189.167]:29393 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S261394AbVDIWMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 18:12:52 -0400
From: Florian Weimer <fw@deneb.enyo.de>
To: David Lang <david.lang@digitalinsight.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	<20050408041341.GA8720@taniwha.stupidest.org>
	<Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
	<20050408071428.GB3957@opteron.random>
	<Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org>
	<4256AE0D.201@tiscali.de>
	<Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org>
	<4256BE7D.5040308@tiscali.de>
	<Pine.LNX.4.58.0504081047200.28951@ppc970.osdl.org>
	<9e473391050408112865ed5d17@mail.gmail.com>
	<7dc90bec2ef0a67aa307b8e81005fa84@dalecki.de>
	<Pine.LNX.4.62.0504081849110.12437@qynat.qvtvafvgr.pbz>
Date: Sun, 10 Apr 2005 00:12:49 +0200
In-Reply-To: <Pine.LNX.4.62.0504081849110.12437@qynat.qvtvafvgr.pbz> (David
	Lang's message of "Fri, 8 Apr 2005 18:50:52 -0700 (PDT)")
Message-ID: <87psx34n1a.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Lang:

>> Databases supporting replication are called high end. You forgot
>> the cats dance around the network this issue involves.
>
> And Postgres (which is Free in all senses of the word) is high end by this 
> definition.

I'm not aware of *any* DBMS, commercial or not, which can perform
meaningful multi-master replication on tables which mainly consist of
text files as records.  All you can get is single-master replication
(which is well-understood), or some rather scary stuff which involves
throwing away updates, or taking extrema or averages (even automatic
3-way merges aren't available).
