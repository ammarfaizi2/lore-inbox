Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317282AbSGTAh6>; Fri, 19 Jul 2002 20:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317283AbSGTAh5>; Fri, 19 Jul 2002 20:37:57 -0400
Received: from admin.nni.com ([216.107.0.51]:22795 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S317282AbSGTAh4>;
	Fri, 19 Jul 2002 20:37:56 -0400
Date: Fri, 19 Jul 2002 20:39:42 -0400
From: Andrew Rodland <arodland@noln.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -ac] Panicking in morse code
Message-Id: <20020719203942.492a6a58.arodland@noln.com>
In-Reply-To: <200207200035.g6K0ZFN11415@devserv.devel.redhat.com>
References: <20020719011300.548d72d5.arodland@noln.com>
	<200207200035.g6K0ZFN11415@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.7.8claws55 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2002 20:35:15 -0400 (EDT)
Alan Cox <alan@redhat.com> wrote:

> > +static const char * morse[] = {
> > +	".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", /* A-H
> > */+	"..", ".---.", "-.-", ".-..", "--", "-.", "---", ".--.", /* I-P
> > */+	"--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", /* Q-X
> > */+	"-.--", "--..",	 	 	 	 	 	 /* Y-Z
> > */+	"-----", ".----", "..---", "...--", "....-",	 	 /* 0-4 */
> > +	".....", "-....", "--...", "---..", "----."	 	 /* 5-9 */
> 
> How about using bitmasks here. Say top five bits being the length,
> lower 5 bits being 1 for dash 0 for dit ?
> 
v2 uses an algorithm suggested to me in private that allows you to fit
7 bits of morse into 8 bits. Very clever method.

> 
> But very nice
> 

Thanks. :)
