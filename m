Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261817AbTCGWVt>; Fri, 7 Mar 2003 17:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261822AbTCGWVt>; Fri, 7 Mar 2003 17:21:49 -0500
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:12971 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S261817AbTCGWVs>; Fri, 7 Mar 2003 17:21:48 -0500
Message-ID: <20030307223202.9244.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: alan@lxorguk.ukuu.org.uk, ciarrocchi@linuxmail.org
Cc: linux-kernel@vger.kernel.org
Date: Sat, 08 Mar 2003 06:32:02 +0800
Subject: Re: [RFC] one line fix in arch/i386/Kconfig
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-3.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

> On Fri, 2003-03-07 at 22:03, Paolo Ciarrocchi wrote:
> > If I say that my cpu is not a PentiumIV why
> > he bothers me about "check for P4 thermal throttling interrupt." ?
> > 
> > This patch show that option only if you select that kind of CPU.
> > 
> > Is it correct ? Does it makes sense ?
> 
> We want people to be able to build a kernel which will run on many systems
> but still use CPU specific features. 

Ah... ok I see the point, I could compile a kernel with PIII optimizations
and then run it on a PIV. 

But it is a complication in the configuration process.
Do we agree on that ?

How about a config entry:
"Leave only the option related to the CPU I selected" ?

Ciao,
           Paolo




-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
