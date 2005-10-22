Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965190AbVJVAUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965190AbVJVAUF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 20:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965191AbVJVAUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 20:20:04 -0400
Received: from xproxy.gmail.com ([66.249.82.207]:47020 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965190AbVJVAUC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 20:20:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PGWxL6at1HIwJuAGddwTM3K8wgXnrrbALFfAlkjsM87cTyOsbYX9sWzgKBBbLLZiySoKAf089wGCwOW5Ar5HQgTblI8hHMVJYbSvVT4rtI7uiGf9LSrhIWQSIO3FWKzxN3pxOX31iqriBNOisxeB7W0xdolLG9atg/x32x9ZtQg=
Message-ID: <5bdc1c8b0510211720q28334177p1b6d6a2cd7fbfd67@mail.gmail.com>
Date: Fri, 21 Oct 2005 17:20:01 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: 2.6.14-rc4-rt7
Cc: Ingo Molnar <mingo@elte.hu>, William Weston <weston@lysdexia.org>,
       cc@ccrma.stanford.edu, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <1129937138.5001.4.camel@cmn3.stanford.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051017160536.GA2107@elte.hu> <20051018072844.GB21915@elte.hu>
	 <1129669474.5929.8.camel@cmn3.stanford.edu>
	 <Pine.LNX.4.58.0510181423200.19498@echo.lysdexia.org>
	 <20051019111943.GA31410@elte.hu>
	 <1129835571.14374.11.camel@cmn3.stanford.edu>
	 <20051020191620.GA21367@elte.hu>
	 <1129852531.5227.4.camel@cmn3.stanford.edu>
	 <20051021080504.GA5088@elte.hu>
	 <1129937138.5001.4.camel@cmn3.stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/05, Fernando Lopez-Lezcano <nando@ccrma.stanford.edu> wrote:
<SNIP>
>
> Here's one with rc5-rt3:
>
> Oct 21 15:01:46 cmn3 kernel: BUG: ktimer expired short without user
> signal! (hald-addon-stor:4309)
> Oct 21 15:01:46 cmn3 kernel: .. expires:   1012/751245500
> Oct 21 15:01:46 cmn3 kernel: .. expired:   1012/750908115
> Oct 21 15:01:46 cmn3 kernel: .. at line:   942
> Oct 21 15:01:46 cmn3 kernel: .. interval:  0/0
><SNIP>

Refresh me. What sort of machine is this and what log file are you
seeing these in. I am surprised at my not seeing them at all, but I
have not gone into the high res timer stuff much. Should I?

- Mark
