Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266635AbUGUW6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266635AbUGUW6P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 18:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266766AbUGUW6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 18:58:15 -0400
Received: from mail-gw4.njit.edu ([128.235.251.32]:18365 "EHLO
	mail-gw4.njit.edu") by vger.kernel.org with ESMTP id S266635AbUGUW6I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 18:58:08 -0400
Date: Wed, 21 Jul 2004 18:58:01 -0400 (EDT)
From: rahul b jain cs student <rbj2@oak.njit.edu>
To: Thomas Giese <Thomas.giese@tgsoftware.de>
cc: Kernel Traffic Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Turning off TCP Delayed acks
In-Reply-To: <007c01c46f47$af32f510$2f8afea9@tgsiemens>
Message-ID: <Pine.GSO.4.58.0407211854530.6744@chrome.njit.edu>
References: <2ks8W-2RR-51@gated-at.bofh.it> <007c01c46f47$af32f510$2f8afea9@tgsiemens>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Giese,

Thank you for your response.

As you wrote TCP_NODELAY is used to turn off Nagle. As per theory this
algo will be running at the sender side and delay acks at the reciever
side. If I turn off Nagel at sender side, wont this lead to the silly
window syndrome ??

Also is it true that Nagles algo and hence delay acks come into play only
if the packet size is small ??

Thanks,
Rahul.

On Wed, 21 Jul 2004, Thomas Giese wrote:

>
> Nagle is automatically turned off on a per socket basis if you set the
> TCP_NODELAY
>  socket option on the socket. Turning nagle off globally is a bit drastic in
> most cases.
>
> Thomas Giese
>
> ----- Original Message -----
> From: "rahul b jain cs student" <rbj2@oak.njit.edu>
> Newsgroups: linux.kernel
> Sent: Wednesday, July 21, 2004 6:30 PM
> Subject: Turning off TCP Delayed acks
>
>
> > Hi everyone,
> >
> > For an experiment, I wanted to turn off the delayed ack system in the
> > kernel so that there is an ack for each and every packet sent by the
> > source. Can anyone give me some ideas on how to go about doing this.
> >
> >
> > Thanks,
> > Rahul.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
>
