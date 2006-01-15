Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751898AbWAOLXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbWAOLXb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 06:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbWAOLXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 06:23:31 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:29621 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751901AbWAOLXa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 06:23:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r/kpmexX2NfFW3eiENU3NxKqx9pCbK3ir4FlhlPOPdMzcEH+Q7KpWv+9xKUDlfDKRFKkjrEOTssUk5QCMfBBrNfz3qmujOY+C4qGddJb4gw/Ri0YFqMnP0jP+HHBk7aS0EVCo1pYhfieDngah/TucII70vsBhwD4pTUCEgXyy+Y=
Message-ID: <39e6f6c70601150323v5f2764d1x4bc10d90bf2104df@mail.gmail.com>
Date: Sun, 15 Jan 2006 09:23:29 -0200
From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: wireless: recap of current issues (other issues)
Cc: jgarzik@pobox.com, linville@tuxdriver.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060114.175140.07007614.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060113213237.GH16166@tuxdriver.com>
	 <20060113222408.GM16166@tuxdriver.com> <43C97693.7000109@pobox.com>
	 <20060114.175140.07007614.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/06, David S. Miller <davem@davemloft.net> wrote:
> From: Jeff Garzik <jgarzik@pobox.com>
> Date: Sat, 14 Jan 2006 17:09:23 -0500
>
> > A big open issue:  should you fake ethernet, or represent 802.11
> > natively throughout the rest of the net stack?
> >
> > The former causes various and sundry hacks, and the latter requires that
> > you touch a bunch of non-802.11 code to make it aware of a new frame class.
>
> The former, most importantly, can cause the packet to get copied.
> Actually, this depends upon how you implement things and when the
> header change occurs.
>
> My vote is for making the whole of the networking 802.11 frame class
> aware.

Agreed :-)

- Arnaldo
