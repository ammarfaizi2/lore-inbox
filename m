Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286211AbRLJKGR>; Mon, 10 Dec 2001 05:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286212AbRLJKGH>; Mon, 10 Dec 2001 05:06:07 -0500
Received: from zero.tech9.net ([209.61.188.187]:45574 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S286211AbRLJKFt>;
	Mon, 10 Dec 2001 05:05:49 -0500
Subject: Re: Strange SAK event
From: Robert Love <rml@tech9.net>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01121011504200.01165@manta>
In-Reply-To: <01121011504200.01165@manta>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.06.08.57 (Preview Release)
Date: 10 Dec 2001 05:04:47 -0500
Message-Id: <1007978688.874.40.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-12-10 at 08:50, vda wrote:

> A few minutes ago I experienced strange thing: I tried to kill hung Midnight 
> Commander with SAK with no success. Top showed that near 100% CPU was sucked 
> by mc. Plain old kill <pid> form another vc killed it, and login prompt 
> appeared.
> 
> Isn't SAK supposed to be able to kill anything on a vc?

SAK actually kills everything that has /dev/console open, IIRC.

	Robert Love

