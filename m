Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263996AbTDWK6M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 06:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263999AbTDWK6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 06:58:11 -0400
Received: from chaos.analogic.com ([204.178.40.224]:55175 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263996AbTDWK6I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 06:58:08 -0400
Date: Wed, 23 Apr 2003 07:11:30 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Wanted: A decent assembler
In-Reply-To: <200304230701_MC3-1-359E-3C3@compuserve.com>
Message-ID: <Pine.LNX.4.53.0304230706420.20223@chaos>
References: <200304230701_MC3-1-359E-3C3@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Apr 2003, Chuck Ebbert wrote:

>
>   Output from 'make bzImage' after making some changes:
>
>         Error: non-constant expression in ".if" statement.
>
>
>   Why is the kernel using a 1-pass assembler?
>

Well it isn't. The AT&T clone assembler will resolve forward
references and it does it by using as many passes as necessary.
It even has a 'reasonable' MACRO capability. I use it quite a
bit to minimize the code-size or to maximize performance in
embedded systems.

Your error shown above is a real error. If you expose the code
that it barfed on, maybe somebody could help you fix the code.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

