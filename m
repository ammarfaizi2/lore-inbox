Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316519AbSGVGsZ>; Mon, 22 Jul 2002 02:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316535AbSGVGsZ>; Mon, 22 Jul 2002 02:48:25 -0400
Received: from smtpde02.sap-ag.de ([155.56.68.170]:24224 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S316519AbSGVGsZ>; Mon, 22 Jul 2002 02:48:25 -0400
From: Christoph Rohland <cr@sap.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 'select' failure or signal should not update timeout
References: <Pine.LNX.4.44.0207210934180.3794-100000@home.transmeta.com>
Organisation: Development SAP J2EE Engine
Date: 22 Jul 2002 08:51:10 +0200
In-Reply-To: <Pine.LNX.4.44.0207210934180.3794-100000@home.transmeta.com>
Message-ID: <znwkjlwh.fsf@sap.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp (Windows [3]))
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sun, 21 Jul 2002, Linus Torvalds wrote:
>> Yes, so everybody really using select assumes it's _at least_ X
>> seconds... So where's the problem?
> 
> Have you tried to _do_ this? I doubt you have, since you think it
> works well already.

Well enough for me and my customers :-)

> The fact is, that if you're doing soft-realtime, you end up having
> to call gettimeofday() a lot more than you should. 

OK, I do not do (soft-)realtime. For non-realtime needs the current
scheme with relative timeouts is easier to use since you do not need
to call gettimeofday at all.

Greetings
		Christoph


