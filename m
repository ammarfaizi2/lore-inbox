Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbWARCzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWARCzN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 21:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWARCzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 21:55:13 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:56799 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964864AbWARCzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 21:55:11 -0500
Subject: Re: [Lse-tech] Re: [ckrm-tech] Re: [PATCH 00/01] Move Exit
	Connectors
From: Lee Revell <rlrevell@joe-job.com>
To: paulmck@us.ibm.com
Cc: Keith Owens <kaos@sgi.com>, John Hesterberg <jh@sgi.com>,
       Matt Helsley <matthltc@us.ibm.com>,
       Jes Sorensen <jes@trained-monkey.org>,
       Shailabh Nagar <nagar@watson.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Jay Lan <jlan@engr.sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       elsa-devel@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       Erik Jacobson <erikj@sgi.com>, Jack Steiner <steiner@sgi.com>
In-Reply-To: <20060118024948.GA10407@us.ibm.com>
References: <20060117172617.GA9283@us.ibm.com>
	 <22822.1137542267@ocs3.ocs.com.au>  <20060118024948.GA10407@us.ibm.com>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 21:55:06 -0500
Message-Id: <1137552907.3587.49.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-17 at 18:49 -0800, Paul E. McKenney wrote:
> - * softirq handlers will have completed, since in some kernels
> + * softirq handlers will have completed, since in some kernels, these
> + * handlers can run in process context, and can block.
>   * 

I was under the impression that softirq handlers can run in process
context in all kernels.  Specifically, in realtime variants softirqs
always run in process context, and in mainline this only happens under
high load.

Lee

