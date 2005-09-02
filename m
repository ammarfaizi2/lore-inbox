Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVIBRwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVIBRwp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 13:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbVIBRwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 13:52:45 -0400
Received: from nproxy.gmail.com ([64.233.182.200]:30195 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750700AbVIBRwp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 13:52:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M8eviBcf3uPpfQhyDq8g1dvlYyXvPNeMyofhfN+D5G38zuX4Rm8CJDyL2+mCpcPnVCwI9cUTFkv1vhYs7i3mzWiLumR36dVRsy+0ZuHx+Qu+wZfsIfdFKrXSZOpHGG33MMghPR5C2piEYYfkrZFhTL4m3rkCcCMFhwVlUTbMHAo=
Message-ID: <81b0412b0509021052458970b2@mail.gmail.com>
Date: Fri, 2 Sep 2005 19:52:43 +0200
From: Alex Riesen <raa.lkml@gmail.com>
To: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: odd socket behavior
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050830065344.86508.qmail@web51807.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050830065344.86508.qmail@web51807.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/05, Phy Prabab <phyprabab@yahoo.com> wrote:
> Hello all,
> 
> I am seeing something odd w/sockets.  I have an app
> that opens and closes network sockets.  When the app
> terminates it releases all fd (sockets) and exists,
> yet running netstat after the app terminates still
> shows the sockets as open!  Am I doing something wrong
> or is this something that is normal?

Do you shutdown(2) them? Are these listening sockets?
