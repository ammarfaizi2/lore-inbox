Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbUB2Nhs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 08:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbUB2Nhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 08:37:48 -0500
Received: from ms002msg.fastwebnet.it ([213.140.2.52]:61133 "EHLO
	ms002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S262048AbUB2Nhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 08:37:46 -0500
From: Paolo Ornati <ornati@fastwebnet.it>
To: Mike Fedyk <mfedyk@matchmail.com>
Subject: Re: 2.6.x: iowait problem while burning a CD: SOLVED
Date: Sun, 29 Feb 2004 14:38:07 +0100
User-Agent: KMail/1.5.4
Cc: Alex Bennee <kernel-hacker@bennee.com>, Rik van Riel <riel@redhat.com>,
       Bill Davidsen <davidsen@tmr.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0402271915590.1747-100000@chimarrao.boston.redhat.com> <200402291027.34655.ornati@fastwebnet.it> <4041C060.8090704@matchmail.com>
In-Reply-To: <4041C060.8090704@matchmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402291438.08097.ornati@fastwebnet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 February 2004 11:35, Mike Fedyk wrote:
> >
> > But I think to have found where the problem is:
> >
> > if I only create an ISO image of 672.4 MB I must wait more then 5
> > minutes... this means about 2.2 MB/s !
>
> How full is your filesystem on average?  If it has been around 90% or
> more, you might be having trouble with fragmentation.

YES.... it was a fragmentation problem ;-)

Now the ISO image creation speed is 9.2 MB/s....

Many thanks.

Bye

-- 
	Paolo Ornati
	Linux v2.6.3

