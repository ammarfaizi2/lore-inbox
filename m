Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWIZH5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWIZH5e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 03:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWIZH5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 03:57:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:63171 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750772AbWIZH5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 03:57:33 -0400
X-Authenticated: #4399952
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.18-rt1
Date: Tue, 26 Sep 2006 09:57:30 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
References: <20060920141907.GA30765@elte.hu> <200609251153.28991.mista.tapas@gmx.net>
In-Reply-To: <200609251153.28991.mista.tapas@gmx.net>
X-Face: %EpW[IH18fBP*R?oz~]%Klbl.q!_(Xs_q"t?K~RVx[c7~3|C3kDdA(8y_KOB\{(Rn(=?utf-8?q?MZhm=0A=09=7B/l=2E?=>O48>i9k<+(,c^Y%mGm)M\+RxuxL4r<7-W63sB$+w\}hkT"Q2?v&N:y\Z
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609260957.30585.mista.tapas@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 September 2006 11:53, Florian Schmidt wrote:
> .config attached
>
> Besides these problems it ran very well for the hours i had it up. Nothing
> suspicious in the logs. Will try another build with more aggressive
> debugging options.

Erm, forget this bug report.

- The long switching to console time seems to be duee to the xorg nv driver

- logging into X via gdm now fails under different kernels, too (though i 
still have no clue why)

- also in 2.6.17-rt8  i can run jack with rt even though no rt-lsm is loaded. 
This is the only really funky one, but i suspect there's some other mechanism 
that explains this.

Regarsd,
Flo

-- 
Palimm Palimm!
http://tapas.affenbande.org
