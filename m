Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271722AbTG2NxH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 09:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271729AbTG2NxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 09:53:07 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:55982
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271722AbTG2NxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 09:53:02 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Timothy Miller <miller@techsource.com>,
       Daniel Phillips <phillips@arcor.de>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Date: Tue, 29 Jul 2003 23:57:19 +1000
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@osdl.org>, ed.sweetman@wmich.edu,
       eugene.teo@eugeneteo.net, linux-kernel@vger.kernel.org
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200307271517.55549.phillips@arcor.de> <3F267CF9.40500@techsource.com>
In-Reply-To: <3F267CF9.40500@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307292357.19647.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003 23:56, Timothy Miller wrote:
> First, since we're dealing with real-time and audio issues, is there any

Actually this is only a tiny part of this work and adequate improvement in 
many different scheduler tweaks have already addressed this. This is now more 
about maintaining good all round interactivity and fairness. Improving audio 
beyond ordinary scheduling tweaks is another issue which may lead to some 
form of soft user RR task. su tasks already can be reniced or made RR to 
help.

> interactive processing in the desired time.  I don't think we should be
> making scheduler tweaks to fix this corner case because it's impossible
> to fix, no?

Your concerns are well founded. However neither Ingo nor I (and all the other 
contributors) are trying to make an audio app scheduler. At some stage a 
modification will be made to the mainline kernel which will have adequate 
audio performance in many (but not all) settings, and more importantly be 
fair and interactive.

Con

