Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262314AbSJOBDn>; Mon, 14 Oct 2002 21:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262312AbSJOBDm>; Mon, 14 Oct 2002 21:03:42 -0400
Received: from tapu.f00f.org ([66.60.186.129]:23203 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S262310AbSJOBDh>;
	Mon, 14 Oct 2002 21:03:37 -0400
Date: Mon, 14 Oct 2002 18:09:30 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andi Kleen <ak@muc.de>
Cc: Daniele Lugli <genlogic@inrete.it>, linux-kernel@vger.kernel.org
Subject: Re: unhappy with current.h
Message-ID: <20021015010930.GB11639@tapu.f00f.org>
References: <3DAB1F00.667B82B5@inrete.it> <m33cr8kavp.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m33cr8kavp.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 10:45:30PM +0200, Andi Kleen wrote:

> How about changing the definition to:

> #define current ((struct task_struct *)get_current())

Is there some magic way to make it an inline function?  That way
collisions would be at the compiler level as opposed to the
preprocessor level (pretending there is a strong separation here).


  --cw

