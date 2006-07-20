Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWGTRoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWGTRoI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 13:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWGTRoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 13:44:08 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:42975 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750806AbWGTRoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 13:44:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ELhb8CEvy6RTDwlS7e6d7lLZ3jWoixuRwoalVaGYSf3OU9ZCyiIWdeaxsXWNBvEnDRSI7ISiSBovYX7GBk6glpxV5arrKupeUBcj4ENUvZrQXg2dhN/qyNX6073SrIij6qrmrmPUXVMav1Ti3Gug0CDlvGpWl9sZFmtrk/l+qRM=
From: Benjamin Cherian <benjamin.cherian.kernel@gmail.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Bug with USB proc_bulk in 2.4 kernel
Date: Thu, 20 Jul 2006 10:43:59 -0700
User-Agent: KMail/1.8.1
References: <mailman.1152332281.24203.linux-kernel2news@redhat.com> <200607181004.55191.benjamin.cherian.kernel@gmail.com> <20060718183313.e8e5a5b2.zaitcev@redhat.com>
In-Reply-To: <20060718183313.e8e5a5b2.zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607201044.00739.benjamin.cherian.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete,

Thanks for the reply.

> > All right then. I'll send you a patch that backports the string caching
> > mechanism from 2.6 in a few days. Would you be able to test it with the
> > 210PU?
>
> Yes, that would be fine.
We should get back to you in a couple weeks with this.

> Although I am starting to think about creating a custom locking
> scheme in devio.c after all. It seems like less work.
What's your timeframe for this? Good luck with it.

Thanks,

Ben
