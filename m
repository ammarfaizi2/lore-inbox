Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271195AbTG1XZW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 19:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271196AbTG1XZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 19:25:22 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:63222 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S271195AbTG1XZT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 19:25:19 -0400
Subject: Re: as / scheduler question
From: Robert Love <rml@tech9.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org
In-Reply-To: <200307290925.10876.kernel@kolivas.org>
References: <200307290908.09065.kernel@kolivas.org>
	 <20030728160117.3f679f01.akpm@osdl.org>
	 <200307290925.10876.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1059435146.931.38.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-5) 
Date: 28 Jul 2003 16:32:26 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-07-28 at 16:25, Con Kolivas wrote:

> If kblockd is reniced to -10 it wont have a problem unless something else
> ends up with the same dynamic priority which would only happen if there
> are interactive tasks reniced to -10. If it's the only process on the
> active array at that priority it _should_ run unaffected.

Even if it is not, it should easily complete what little it has to do
within 25ms... so Ingo's patches should not affect it.

	Robert Love


