Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269015AbUIXWS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269015AbUIXWS1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 18:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269020AbUIXWS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 18:18:26 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:43753 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269015AbUIXWSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 18:18:25 -0400
Subject: Re: [PATCH] oom_pardon, aka don't kill my xlock
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thomas Habets <thomas@habets.pp.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200409242158.40054.thomas@habets.pp.se>
References: <200409230123.30858.thomas@habets.pp.se>
	 <20040923234520.GA7303@pclin040.win.tue.nl>
	 <1096031971.9791.26.camel@localhost.localdomain>
	 <200409242158.40054.thomas@habets.pp.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096060549.10797.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 24 Sep 2004 22:15:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-24 at 20:58, Thomas Habets wrote:
> And also, I'd like to see how a misbehaving airline passenger could start to 
> gain weight not originally on the plane, causing the flight attendants to 
> start executing people because of OOF. And IIRC most airlines don't like 
> having women onboard who are way too pregnant, so no forking either.

The zero over commit code makes sure that we have enough swap/memory for
fillable address space. It means the application will always be told
when it takes an action that it cannot do it, rather than finding out
later and being killed.

Alan

