Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbULRUi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbULRUi1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 15:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbULRUiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 15:38:24 -0500
Received: from main.gmane.org ([80.91.229.2]:25507 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261227AbULRUiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 15:38:15 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Joseph Seigh" <jseigh_02@xemaps.com>
Subject: Re: What does atomic_read actually do?
Date: Sat, 18 Dec 2004 15:43:52 -0500
Message-ID: <opsi707edhs29e3l@grunion>
References: <opsi7o5nqfs29e3l@grunion>  <1103394867.4127.18.camel@laptopd505.fenrus.org> <opsi7xcuizs29e3l@grunion> <1103399680.4127.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.ne.client2.attbi.com
User-Agent: Opera M2/7.54 (Win32, build 3865)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Dec 2004 20:54:40 +0100, Arjan van de Ven <arjan@infradead.org>  
wrote:

> On Sat, 2004-12-18 at 14:20 -0500, Joseph Seigh wrote:
>> I mean atomic in the either old or new sense.  I'm wondering what
>> guarantees
>> the atomicity.  Not the C standard.  I can see the gcc compiler uses a  
>> MOV
>> instruction to load the atomic_t from memory which is guaranteed atomic  
>> by
>> the architecture if aligned properly.  But gcc does that for any old int
>> as far as I can see, so why use atomic_read?
>
> it does so on *x86

Is this documented for gcc anywhere?  Just because it does so doesn't
mean it's guaranteed.

Joe Seigh

