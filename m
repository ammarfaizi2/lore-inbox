Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbVJSPM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbVJSPM1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 11:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbVJSPM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 11:12:27 -0400
Received: from xproxy.gmail.com ([66.249.82.206]:15769 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751085AbVJSPM0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 11:12:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sINmlyiO9Ee7Wo2YBi3d0YBrjnjVVAGpkl4P/ohNz14nYP9iFZtsizqUMDLOKu2RayQYBd9H2J05TsjJf9+0eoXbqR6NPEhEy31o0mBJldY6lyfneJPwvtaVj9G0761Or+BGqIVazg2maup/ZqMYlG5E/fc51vfs6FDytn5elZY=
Message-ID: <5bdc1c8b0510190812l6b9574cft14664fa40f1225ce@mail.gmail.com>
Date: Wed, 19 Oct 2005 08:12:25 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: -rt10 build problem [WAS]Re: scsi_eh / 1394 bug - -rt7
Cc: Steven Rostedt <rostedt@goodmis.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051019145435.GA6455@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510190750s377a2696kf9c323789b392664@mail.gmail.com>
	 <20051019145435.GA6455@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/05, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Mark Knecht <markknecht@gmail.com> wrote:
>
> > Problem building 2.6.14-rc4-rt10. The only change to my config file
> > was to turn on a few options for Mac disks. I doubt that's involved
> > with this. I will send the .config file if requested.
>
> does the patch below fix it?
>
>         Ingo
>

Sorry. Please resend the patch as a file. My trying to copy it from
GMail has apparently killed it:

lightning linux # patch -p1 --dry-run <~mark/patch-ktimer
patching file kernel/ktimers.c
Hunk #1 FAILED at 1097.
1 out of 1 hunk FAILED -- saving rejects to file kernel/ktimers.c.rej
lightning linux #
