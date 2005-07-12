Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVGLCRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVGLCRK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 22:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbVGLCRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 22:17:09 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:62140 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261760AbVGLCRI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 22:17:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ARG1iqGCtcHOm+RiW9VAeba9hlrWbtM6HO1gOVznUSwhXxKb6CIc2+ERnQqanV9TWLfMiYvX8YEElOxZyTEwMFkGT78rz3WuwAu3zRrC/5LHBpKCwExvn0jws8+xvFw03orV52dJASh6Cg5AAExb1wMw7Elz8NrgJKqAhBfMLDY=
Message-ID: <21d7e9970507111917105fda41@mail.gmail.com>
Date: Tue, 12 Jul 2005 12:17:08 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Merging relayfs?
Cc: Tom Zanussi <zanussi@us.ibm.com>, linux-kernel@vger.kernel.org,
       karim@opersys.com, varap@us.ibm.com, richardj_moore@uk.ibm.com
In-Reply-To: <20050711184558.6346e77c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <17107.6290.734560.231978@tut.ibm.com>
	 <20050711184558.6346e77c.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Hi Andrew, can you please merge relayfs?
> 
> I guess so.  Would you have time to prepare a list of existing and planned
> applications?

I have a plan to use it for something that no-one knows about yet..

I was going to use it for doing a DRM packet debug logger... to try
and trace hangs in the system, using printk doesn't really help as
guess what it slows the machine down so much that your races don't
happen... I wrote some basic code for this already.. and I'm hoping to
use some work time to get it finished at some stage...

Dave.
