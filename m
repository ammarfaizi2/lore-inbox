Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285193AbRLXSLC>; Mon, 24 Dec 2001 13:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285185AbRLXSKx>; Mon, 24 Dec 2001 13:10:53 -0500
Received: from 213-96-124-18.uc.nombres.ttd.es ([213.96.124.18]:47597 "HELO
	dardhal") by vger.kernel.org with SMTP id <S285195AbRLXSKk>;
	Mon, 24 Dec 2001 13:10:40 -0500
Date: Mon, 24 Dec 2001 19:10:32 +0100
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@internautas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Data sitting and remaining in Send-Q
Message-ID: <20011224181031.GA7934@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011224180142.E2461@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011224180142.E2461@lug-owl.de>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 24 December 2001, at 18:01:42 +0100,
Jan-Benedict Glaw wrote:

> I've got some problem with a freshly installed Debian sid system.
> It's running with 2.4.16, 2.4.17-rc2 and 2.4.17 (the problem
> appears on all these kernels) and something seems to break ssh.
> 
I don't know if this has something to do with your problem, but
bugs.debian.org has a _long_ list of reported bugs for ssh, many of them
with respect to ssh's X-forwarding.

My own experience with Debian's ssh is that, sooner or later,
X-forwarding fails, with Send-Q (or Recv-Q) in the server side
completely full. The server side was Debian Sid, and client side was
Debian Woody, and it happened with both a simple xclock and gkrellm (ssh
remoteserver xclock, ssh remoteserver gkrellm).

However, interactive shells didn't seem to show this problem.

-- 
José Luis Domingo López
Linux Registered User #189436     Debian Linux Woody (P166 64 MB RAM)
 
jdomingo AT internautas DOT   org  => Spam at your own risk

