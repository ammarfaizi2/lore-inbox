Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbTEFILk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 04:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTEFILk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 04:11:40 -0400
Received: from inpbox.inp.nsk.su ([193.124.167.24]:60602 "EHLO
	inpbox.inp.nsk.su") by vger.kernel.org with ESMTP id S261798AbTEFILj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 04:11:39 -0400
Date: Tue, 6 May 2003 15:21:02 +0700
From: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
Reply-To: D.A.Fedorov@inp.nsk.su
To: Terje Eggestad <terje.eggestad@scali.com>
cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <1052206053.15887.0.camel@pc-16.office.scali.no>
Message-ID: <Pine.SGI.4.10.10305061518110.8255699-100000@Sky.inp.nsk.su>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 May 2003, Terje Eggestad wrote:

> > On 6 May 2003, Terje Eggestad wrote:
> > 
> > > Good point, it should actually be very simple.
> > > from /proc/ksyms we've got teh adresses of the sys_*, then from
> > > asm/unistd.h we got the order.
> > 
> > /proc/ksyms shows only exported symbols, is not it?

> Yes, but it should be enough

But how? When some global will not be exported, it would not be listed
in /proc/ksyms.

