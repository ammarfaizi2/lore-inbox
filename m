Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbVERA5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbVERA5e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 20:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVERA5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 20:57:34 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:5324 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262030AbVERA5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 20:57:31 -0400
Subject: Re: Illegal use of reserved word in system.h
From: Lee Revell <rlrevell@joe-job.com>
To: "Gilbert, John" <JGG@dolby.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2692A548B75777458914AC89297DD7DA08B0866D@bronze.dolby.net>
References: <2692A548B75777458914AC89297DD7DA08B0866D@bronze.dolby.net>
Content-Type: text/plain
Date: Tue, 17 May 2005 20:57:30 -0400
Message-Id: <1116377850.2909.0.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-17 at 17:51 -0700, Gilbert, John wrote:
> Hello,
> The use of "new" as a variable name in the macro "__cmpxchg" breaks
> builds of other programs that link to include/asm-i386/system.h
> I'd like to request that this be renamed to something else, like mynew
> or krnew.

The kernel is written in C.  "new" is not reserved in C.  Userspace
programs should not include kernel headers anyway.

Lee

