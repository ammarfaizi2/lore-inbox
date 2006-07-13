Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbWGMQqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbWGMQqW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 12:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWGMQqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 12:46:22 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:61389 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030240AbWGMQqV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 12:46:21 -0400
Subject: Re: [PATCH] s390 hypfs fixes for 2.6.18-rc1-mm1
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Michael Holzheu <HOLZHEU@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <44B60CB3.4000806@fr.ibm.com>
References: <44B5C7CE.6090606@us.ibm.com> <44B5C971.7030403@us.ibm.com>
	 <44B60CB3.4000806@fr.ibm.com>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 09:48:41 -0700
Message-Id: <1152809321.30096.0.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 11:04 +0200, Cedric Le Goater wrote:
> Badari Pulavarty wrote:
> > Badari Pulavarty wrote:
> >> Hi Micheal,
> >>
> >> I made fixes to hypfs to fit new vfs ops interfaces. I am not sure if
> >> we really
> >> need to vectorize aio interfaces, can you check and see if this is okay ?
> >>
> >> And also, I am not sure what hypfs_aio_write() is actually doing.
> >> It doesn't seem to be  doing with "buf" ?
> >>
> >> (BTW - I have no way to verify these change. Can you give them a spin ?)
> >>
> >> Thanks,
> >> Badari
> > 
> > Here is the updated version ..
> 
> indeed it compiles better :)
> 
> it boots fine. what kind of tests do you run ?

I have no way of testing hypfs, since I don't even know what it does :(
Is it possible to test it for me ?

Thanks,
Badari

