Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbULPLys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbULPLys (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 06:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbULPLys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 06:54:48 -0500
Received: from host-3.tebibyte16-2.demon.nl ([82.161.9.107]:40461 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S261925AbULPLyr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 06:54:47 -0500
Message-ID: <41C1777A.3080105@tebibyte.org>
Date: Thu, 16 Dec 2004 12:54:34 +0100
From: Chris Ross <chris@tebibyte.org>
Organization: At home (Eindhoven, The Netherlands)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: slow OOM killing with 2.6.9?
References: <41C065A2.4040504@nortelnetworks.com>
In-Reply-To: <41C065A2.4040504@nortelnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Chris Friesen escreveu:
> I've got a ppc box with 2GB of ram, running 2.6.9.
> 
> If I run a few instances of memory chewing programs, eventually the 
> OOM-killer kicks in.  At that point, the machine locks up for about 10 
> seconds while deciding what to kill.

OOM killing is known to be broken in 2.6.9, specifically it kills things 
even when the machine isn't out of memeory and/or kills the "wrong" 
things when it is. See threads assim for more details.

The OOM Killer is working properly again in 2.6.10-rc2-mm4. Could you 
try that kernel and report whether it fixed your problems too?

Regards,
Chris R.
