Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312494AbSDEMNk>; Fri, 5 Apr 2002 07:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312497AbSDEMNa>; Fri, 5 Apr 2002 07:13:30 -0500
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:51593 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S312494AbSDEMNK>; Fri, 5 Apr 2002 07:13:10 -0500
Date: Fri, 5 Apr 2002 14:13:07 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: joeja@mindspring.com, linux-kernel@vger.kernel.org
Subject: Re: faster boots?
In-Reply-To: <3CAD55F7.55C56F96@aitel.hist.no>
Message-ID: <Pine.GSO.4.05.10204051407001.19669-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

improving kernel bootup time:

	what about saving the parameters for successfully loaded modules?
	(like the IRQs and other stuff which gets autodetected.)
	- and when those modules are loaded for the second time, the
		saves values will be used, without the need to do
		autoprobing (don't know how much time that will
		save, but it should save quite some time for people
		having all the drivers in the kernel, but no matching
		hardware)
		- this will only work if there are no static inits,
			but everything's modularized (which should
			be in the works?)
	- also you need to have a parameter to reprobe the whole modules


- this would also give a nice template for building a customized kernel
(well again for people who are not really used to do things like that)

	just my $0.02

		tm

-- 
in some way i do, and in some way i don't.

