Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136197AbREGPia>; Mon, 7 May 2001 11:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136227AbREGPiU>; Mon, 7 May 2001 11:38:20 -0400
Received: from zero.tech9.net ([209.61.188.187]:40207 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S136213AbREGPiK>;
	Mon, 7 May 2001 11:38:10 -0400
Subject: Re: A simple question.
From: Robert "M." Love <rml@tech9.net>
To: Hai Xu <xhai@CLEMSON.EDU>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000701c0d70a$923fbf70$3cac7f82@crb50>
In-Reply-To: <000701c0d70a$923fbf70$3cac7f82@crb50>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 07 May 2001 11:34:52 -0400
Message-Id: <989249704.1614.0.camel@icbm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 May 2001 11:29:56 -0400, Hai Xu wrote:
> After I compile and upgrade to a newer Kernel, do I need to copy the
> System.map from /usr/src/linux/ to /boot/System-xxxx and link it to
> System.map

yes, you do. but System.map is only needed to do symbol lookups, for
times like debugging.

note most distributions link /boot/System.map to the correct System.map
(in boot) on startup. if your's does not, its a simple script:

ln -sf /boot/System.map-`uname -r` /boot/System.map


-- 
Robert M. Love
rml@tech9.net
rml@ufl.edu

