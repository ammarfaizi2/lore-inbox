Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbUC1USO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 15:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbUC1USO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 15:18:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:6105 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262438AbUC1USJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 15:18:09 -0500
X-Authenticated: #1226656
Date: Sun, 28 Mar 2004 22:18:06 +0200
From: Marc Giger <gigerstyle@gmx.ch>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: status of Linux on Alpha?
Message-Id: <20040328221806.7fa20502@vaio.gigerstyle.ch>
In-Reply-To: <20040328204308.C14868@jurassic.park.msu.ru>
References: <yw1xsmftnons.fsf@ford.guide>
	<20040328201719.A14868@jurassic.park.msu.ru>
	<yw1xoeqhndvl.fsf@ford.guide>
	<20040328204308.C14868@jurassic.park.msu.ru>
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan, Hi Måns

I haven't found the time to look deeper into the problem. All what I can
say ATM is, it is real and exists!

Ivan, perhaps you can give me some useful advise how to debug this
successfully? I think we should begin to try isolating the problem to a
single part of the kernel. 
Is it possible that we have a deadlock in the VFS part? After a
while every process that accesses a file will be blocked (already
described).

Regards

Marc

On Sun, 28 Mar 2004 20:43:08 +0400
Ivan Kokshaysky <ink@jurassic.park.msu.ru> wrote:

> On Sun, Mar 28, 2004 at 06:19:10PM +0200, Måns Rullgård wrote:
> > Well, I'm using both raid and xfs...
> 
> OK, good to know.
> 
> > So you're saying that if 2.6.3 is stable, 2.6.4 and later should be
> > fine too?
> 
> I haven't tried 2.6.5 yet, but with 2.6.4 couple of my boxes have
> 16 days uptime and no problems so far.
> 
> Ivan.
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
