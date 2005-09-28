Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbVI1Uha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVI1Uha (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 16:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbVI1Uha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 16:37:30 -0400
Received: from xproxy.gmail.com ([66.249.82.199]:38988 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750809AbVI1Uh3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 16:37:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XpwiWKhaiKGa4sWS/QJbhesLZHzepNnDUDIsnh0fDSTjwyyzv252j1xIZ3uR886EanP9VlBEjz9q3m+/vpV7RdKN/kit/RWToCPyPUGJxey64Bd8st8ev+NdUAC/5OH2wpkRWAmT7ITVN7LJzG34zpj00oOKHWjCuF/KtXb85cc=
Message-ID: <5bdc1c8b05092813376ad69717@mail.gmail.com>
Date: Wed, 28 Sep 2005 13:37:28 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: dwalker@mvista.com
Subject: Re: 2.6.14-rc2-rt6 build problems
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1127939455.9378.1.camel@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b05092808596a22847a@mail.gmail.com>
	 <5bdc1c8b05092813131955ab8f@mail.gmail.com>
	 <1127939455.9378.1.camel@dhcp153.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/05, Daniel Walker <dwalker@mvista.com> wrote:
> On Wed, 2005-09-28 at 13:13 -0700, Mark Knecht wrote:
>
> > 1) I downloaded 2.6.13 and built this correctly.
> >
> > 2) I applied the 2.6.14-rc2 patch. This built correctly also.
> >
> > 3) I applied the 2.6.14-rc2-rt5 patch. It failed as foloows:
>
> You had "Complete Preemption (Real-Time)" selected in the first config
> you sent, did you have that selected during this compile also ?
>
> Daniel

No, in this one I tried making as few changes as possible to the
default configuration. This pass was

Preemption Mode (No Forced Preemption (Server))

I would prefer to finally get to Complete Preemption as I'm doing
audio recording, etc., but I thought I'd take it in steps.

- Mark
