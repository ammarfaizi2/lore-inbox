Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbVL1LTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbVL1LTn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 06:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbVL1LTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 06:19:43 -0500
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:698 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964787AbVL1LTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 06:19:43 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Paolo Ornati <ornati@fastwebnet.it>
Subject: Re: [SCHED] Totally WRONG prority calculation with specific test-case (since 2.6.10-bk12)
Date: Wed, 28 Dec 2005 22:19:23 +1100
User-Agent: KMail/1.9
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
References: <20051227190918.65c2abac@localhost> <200512281027.00252.kernel@kolivas.org> <20051228120129.2a8d1199@localhost>
In-Reply-To: <20051228120129.2a8d1199@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512282219.24185.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 December 2005 22:01, Paolo Ornati wrote:
> 	after some hours of running transcode (with me away from the
> machine) I've found a totally UNUSABLE system. Transcode was the king
> of the machine and everything else get almost no CPU time. Switching to
> a Text-Console takes something like 10s (or something like that). When
> I was finally logged in as root I've reniced transcode and companyto +19
> and the system was usable again ;)
>
> To get things even more STRANGE: another time that this happened I've
> done the same thing except that I've reniced them to "0" (the same nice
> level they were running) ---> And the system became usable again (with
> the usual slow down but still usable).
>
> This is what I remember. Now I think we can agree that there is
> something wrong... no?

This latter thing sounds more like your transcode job pushed everything out to 
swap... You need to instrument this case better.

Con
