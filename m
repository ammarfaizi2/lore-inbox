Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265003AbTFQXNv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 19:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265006AbTFQXNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 19:13:51 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:4508 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S265003AbTFQXNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 19:13:49 -0400
Date: Tue, 17 Jun 2003 20:25:22 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Eric Valette <eric.valette@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.4.22 timeline was RE: 2.4.21-rc7 ACPI broken
In-Reply-To: <3EE66C86.8090708@free.fr>
Message-ID: <Pine.LNX.4.55L.0306172019550.31986@freak.distro.conectiva>
References: <3EE66C86.8090708@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 11 Jun 2003, Eric Valette wrote:

> Marcelo Tosati wrote:
>
>  >The main reason I didnt want to merge it was due to its size. Its just
>  >too big.
>
>  >> Please stop leading me along. Will you EVER merge it?
>
>  >Yes, I want to, and will merge it. In 2.4.23-pre.
>
> This kind of mails and sentence makes you lost your credibility :
> 	1) You said that ACPI will be merged in 2.4.22-pre,
> 	2) For many people ACPI (and aic7xxx) is top priority for 2.4 kernel
> (see various post including alan). The reason being that most laptop are
> unusable nowadays without ACPI,
> 	3) You do not explicitely says what you plan for 2.4.22...

My plan for 2.4.22 is:

 - Include the new aic7xxx driver.
 - Include ACPI. (I now realized its importance). Already discussing with
   Andrew the best way to do it.
 - Fix the latency/interactivity problems (Chris, Nick and Andrea working
on that)
 - Merge obviously correct -aa VM patches.

Those are the most important things that are needed now, I think.

