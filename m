Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282206AbRK1Xvx>; Wed, 28 Nov 2001 18:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282205AbRK1Xvq>; Wed, 28 Nov 2001 18:51:46 -0500
Received: from zero.tech9.net ([209.61.188.187]:48394 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S282192AbRK1Xui>;
	Wed, 28 Nov 2001 18:50:38 -0500
Subject: Re: [PATCH] remove BKL from drivers' release functions
From: Robert Love <rml@tech9.net>
To: "David C. Hansen" <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C05767F.7050304@us.ibm.com>
In-Reply-To: <200111282305.fASN5ap02626@localhost.localdomain>
	<3C057358.95C181A5@zip.com.au>  <3C05767F.7050304@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 28 Nov 2001 18:50:41 -0500
Message-Id: <1006991442.817.4.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-11-28 at 18:42, David C. Hansen wrote:

> Whoops.   Here's another patch to throw on top of the first one.

You guys still looking to make global spinlocks static (i.e. not moving
to finer-grained locking but just making sure local locks are properly
static) ?

My tree has some work to this effect, perhaps I can toss you a patch ...

	Robert Love



