Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267155AbSLaFUP>; Tue, 31 Dec 2002 00:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267156AbSLaFUP>; Tue, 31 Dec 2002 00:20:15 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:14431 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267155AbSLaFUO>; Tue, 31 Dec 2002 00:20:14 -0500
Date: Tue, 31 Dec 2002 00:28:37 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200212310528.gBV5Sbn29105@devserv.devel.redhat.com>
To: "Emiliano Gabrielli" <emiliano.gabrielli@roma2.infn.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: Indention - why spaces?
In-Reply-To: <mailman.1041274740.23755.linux-kernel2news@redhat.com>
References: <20021230122857.GG10971@wiggy.net>          <200212301249.gBUCnXrV001099@darkstar.example.net>          <20021230131725.GA16072@suse.de> <mailman.1041274740.23755.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IMHO and in my personal projects I use the following indenting rules:
> 
> 1) use TABs for _indentation_
> 2) use SPACEs for aligning
> 
> here is an exaple:
> 
><tab><tab>if (cond) {
><tab><tab><tab>dosometing;
><tab><tab><tab>printf("This is foo: '%s', and this bar: '%d'",
><tab><tab><tab>       foo, bar);

BTW, this practice is codified in Solaris developer's guidelines.
They even have a perl script called "hdrchk" which is run before
commits and tells about violations. Actually, the Sun requirement
is to have exactly 4 spaces, but it sounds a little too anal to me.

-- Pete
