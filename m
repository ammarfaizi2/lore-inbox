Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbUJ1Pcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbUJ1Pcs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 11:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbUJ1PbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 11:31:00 -0400
Received: from host-3.tebibyte16-2.demon.nl ([82.161.9.107]:38916 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S261715AbUJ1P1k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:27:40 -0400
Message-ID: <41810FD6.9020202@tebibyte.org>
Date: Thu, 28 Oct 2004 17:27:18 +0200
From: Chris Ross <chris@tebibyte.org>
Organization: At home (Eindhoven, The Netherlands)
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       javier@marcet.info, linux-kernel@vger.kernel.org, kernel@kolivas.org,
       barry <barry@disus.com>
Subject: Re: Mem issues in 2.6.9 (ever since 2.6.9-rc3) and possible cause
References: <Pine.LNX.4.44.0410251823230.21539-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0410251833210.21539-100000@chimarrao.boston.redhat.com> <20041028120650.GD5741@logos.cnet>
In-Reply-To: <20041028120650.GD5741@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marcelo Tosatti escreveu:
> Can you please test Rik's patch with your spurious OOM kill testcase?

Do you have a particular test case in mind? Is it accessible to the rest 
of us? If you send it to me I will run it on my 64MB P2 machine, which 
makes a very good test rig for the oom_killer because it is normally 
plagued by it.

I have already run Rik's patch to great success using my test case of 
compiling umlsim. Without the patch this fails every time at the linking 
the UML kernel stage.

Regards,
Chris R.
