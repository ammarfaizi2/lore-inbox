Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTLWQ1O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 11:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbTLWQ1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 11:27:13 -0500
Received: from vena.lwn.net ([206.168.112.25]:456 "HELO lwn.net")
	by vger.kernel.org with SMTP id S261879AbTLWQ1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 11:27:06 -0500
Message-ID: <20031223162703.8870.qmail@lwn.net>
To: Ben Srour <srour@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compiling modules after 2.4.* --> 2.6.0 upgrade 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Tue, 23 Dec 2003 02:20:06 CST."
             <Pine.LNX.4.44.0312230211500.28609-100000@data.upl.cs.wisc.edu> 
Date: Tue, 23 Dec 2003 09:27:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm attempting to port a module I wrote for the 2.4 series to 2.6 but I
> get the following error when I try and insmod:
> 
> 	root@dimension# /usr/sbin/insmod gpstest.o
> 	insmod: error inserting 'gpstest.o': -1 Invalid module format
> 	root@dimension#

Try inserting gpstest.ko instead.

Don't have a gpstest.ko?  Head off to 

	http://lwn.net/Articles/driver-porting/

to see how to make one.

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
