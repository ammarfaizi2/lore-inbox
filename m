Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290867AbSARXGi>; Fri, 18 Jan 2002 18:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290868AbSARXG2>; Fri, 18 Jan 2002 18:06:28 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:5643 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S290867AbSARXGN>;
	Fri, 18 Jan 2002 18:06:13 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Bruce Harada <bruce@ask.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wavelan_cs update (Pcmcia backport) 
In-Reply-To: Your message of "Sat, 19 Jan 2002 00:10:29 +0900."
             <20020119001029.42599989.bruce@ask.ne.jp> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 19 Jan 2002 10:06:01 +1100
Message-ID: <14102.1011395161@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jan 2002 00:10:29 +0900, 
Bruce Harada <bruce@ask.ne.jp> wrote:
>On Fri, 18 Jan 2002 00:07:56 -0500
>Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>> -       * (does it work for everybody XXX - especially old cards...) */
>> +       * (does it work for everybody ??? - especially old cards...) */
>> you are reverting a change - "???" causes a trigraph-related warning in
>> newer gcc
>
>Just asking, but isn't it just a bit bogus for gcc to raise warnings about
>things in comments?

Trigraph conversion is done before lexical analysis, gcc does not know
if ??? is inside a comment at that stage.

