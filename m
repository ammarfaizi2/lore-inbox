Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287966AbSATEaz>; Sat, 19 Jan 2002 23:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287948AbSATEaq>; Sat, 19 Jan 2002 23:30:46 -0500
Received: from femail23.sdc1.sfba.home.com ([24.0.95.148]:26594 "EHLO
	femail23.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S287946AbSATEaa>; Sat, 19 Jan 2002 23:30:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Ken Brownfield <brownfld@irridia.com>, Doug Alcorn <lathi@seapine.com>
Subject: Re: rm-ing files with open file descriptors
Date: Sat, 19 Jan 2002 15:23:57 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87lmevjrep.fsf@localhost.localdomain> <20020118152833.A30386@asooo.flowerfire.com>
In-Reply-To: <20020118152833.A30386@asooo.flowerfire.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020120043027.TXTJ9511.femail23.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 January 2002 04:28 pm, Ken Brownfield wrote:
> This is actually a long-standing UNIXism that is pretty heavily relied-
> upon -- for example, opening a temporary file then unlinking it before
> use "guarantees" that the file will not stick around in case the app
> crashes before it can properly close and unlink.

It's fun with named pipes, too.  Allows you to use the child's PID as the 
temp file name really easily...

Rob
