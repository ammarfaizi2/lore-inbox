Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271242AbTHHGFw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 02:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271244AbTHHGFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 02:05:52 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:31385 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S271242AbTHHGFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 02:05:50 -0400
From: Daniel Phillips <phillips@arcor.de>
To: rob@landley.net, Ed Sweetman <ed.sweetman@wmich.edu>,
       Eugene Teo <eugene.teo@eugeneteo.net>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Date: Fri, 8 Aug 2003 07:08:37 +0100
User-Agent: KMail/1.5.3
Cc: LKML <linux-kernel@vger.kernel.org>, kernel@kolivas.org,
       Davide Libenzi <davidel@xmailserver.org>
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200308071642.55517.phillips@arcor.de> <200308071651.07522.rob@landley.net>
In-Reply-To: <200308071651.07522.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308080708.37966.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 August 2003 21:51, Rob Landley wrote:
> Uh-huh.
>
> So with SCHED_SOFTRR, if the system gets heavily loaded enough later on
> then the SOFTRR tasks can get demoted and start skipping.

No.  A SOFTRR task only becomes SCHED_NORMAL if the total load of *realtime* 
tasks exceeds a threshold.

> I fail to see how this is an improvement on Con's "carpet bomb the problem
> with heuristics out the wazoo" approach? ... (I like heuristcs.  They're
> like Duct Tape.  I like Duct Tape.)

Danger, danger!  Man with duct tape loose in kernel!  Seal off the bulwarks 
and flood the lower compartments!

Regards,

Daniel

