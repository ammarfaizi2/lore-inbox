Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317466AbSGJBpU>; Tue, 9 Jul 2002 21:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317467AbSGJBpT>; Tue, 9 Jul 2002 21:45:19 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:36626 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317466AbSGJBpT>; Tue, 9 Jul 2002 21:45:19 -0400
Date: Tue, 9 Jul 2002 22:15:17 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Robert Love <rml@mvista.com>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Rick Lindsley <ricklind@us.ibm.com>, Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
Message-ID: <20020710011517.GA1323@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Robert Love <rml@mvista.com>, Dave Hansen <haveblue@us.ibm.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Rick Lindsley <ricklind@us.ibm.com>, Greg KH <greg@kroah.com>,
	kernel-janitor-discuss <kernel-janitor-discuss@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <20020709201703.GC27999@kroah.com> <200207092055.g69Ktt418608@eng4.beaverton.ibm.com> <20020709210053.GF25360@holomorphy.com> <1026249175.1033.1178.camel@sinai> <3D2AF10A.1020603@us.ibm.com> <1026250151.1623.1185.camel@sinai> <3D2AF6EA.1030008@us.ibm.com> <1026251269.5516.1187.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1026251269.5516.1187.camel@sinai>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 09, 2002 at 02:47:49PM -0700, Robert Love escreveu:
> On Tue, 2002-07-09 at 07:44, Dave Hansen wrote:
> 
> > The Stanford Checker or something resembling it would be invaluable 
> > here.  It would be a hell of a lot better than my litle patch!
> 
> The Stanford Checker would be infinitely invaluable here -- agreed.
> 
> Anything that can graph call chains and do analysis... we can get it to
> tell us exactly who and what.

Try smatch:

http://smatch.sf.net

And see if you can write a smatch script to get a good broom for this trash 8)

- Arnaldo
