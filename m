Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263083AbTJFRM2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 13:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264031AbTJFRM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 13:12:27 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:28809 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263083AbTJFRM0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 13:12:26 -0400
Date: Mon, 6 Oct 2003 18:12:23 +0100
From: Jamie Lokier <jamie@shareable.org>
To: bert hubert <ahu@ds9a.nl>,
       "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>,
       "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: Futex
Message-ID: <20031006171223.GB559@mail.shareable.org>
References: <D9B4591FDBACD411B01E00508BB33C1B01EC852D@mesadm.epl.prov-liege.be> <20031006075039.GA12376@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006075039.GA12376@outpost.ds9a.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:
> On Mon, Oct 06, 2003 at 09:22:19AM +0200, Frederick, Fabian wrote:
> > Hi,
> > 
> > 	Why don't we have any futex doc included ?
> > Nothing about futexfs nor userspace futex usage ....
> 
> http://ds9a.nl/futex-manpages/

Those docs are a little out of date and incomplete, though.

There's no mention of FUTEX_REQUEUE, and no mention of the important
token-passing property: that the value returned from FUTEX_WAKE is
equal to the number of calls which return 0 from FUTEX_WAIT.
(Only when FUTEX_FD is not used; FUTEX_FD is broken with respect to
token passing at the moment).

-- Jamie
