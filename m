Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbTEFCTL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 22:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbTEFCTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 22:19:11 -0400
Received: from inpbox.inp.nsk.su ([193.124.167.24]:33955 "EHLO
	inpbox.inp.nsk.su") by vger.kernel.org with ESMTP id S262261AbTEFCTK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 22:19:10 -0400
Date: Tue, 6 May 2003 09:23:46 +0700
From: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
Reply-To: D.A.Fedorov@inp.nsk.su
To: Terje Eggestad <terje.eggestad@scali.com>
cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <1052174975.1000.5.camel@eggis1>
Message-ID: <Pine.SGI.4.10.10305060920320.7773473-100000@Sky.inp.nsk.su>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 May 2003, Terje Eggestad wrote:

> Good point, it should actually be very simple.
> from /proc/ksyms we've got teh adresses of the sys_*, then from
> asm/unistd.h we got the order.

/proc/ksyms shows only exported symbols, is not it?

> Then search thru /dev/kmem until you find the right string og addresses,
> and you got sys_call_table. 
> 
> Dirty but it should be portable. 

