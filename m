Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287862AbSBHXua>; Fri, 8 Feb 2002 18:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287874AbSBHXuR>; Fri, 8 Feb 2002 18:50:17 -0500
Received: from coffee.Psychology.McMaster.CA ([130.113.218.59]:37510 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S287862AbSBHXuH>; Fri, 8 Feb 2002 18:50:07 -0500
Date: Fri, 8 Feb 2002 18:51:52 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: <hahn@coffee.psychology.mcmaster.ca>
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Read-Copy Update 2.5.4-pre2
In-Reply-To: <20020208234217.A18466@in.ibm.com>
Message-ID: <Pine.LNX.4.33.0202081847020.30304-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> in lkml in the past. Currently there are several potential 
> applications of RCU that are being developed and some of them look 
> very promising. Our revamped webpage 

yes, but have you evaluated whether it's noticably better than
other forms of locking?  for instance, couldn't your dcache example
simply use BR locks?

