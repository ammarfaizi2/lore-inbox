Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752378AbWCFLEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbWCFLEf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 06:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752381AbWCFLEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 06:04:35 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:16495 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752378AbWCFLEe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 06:04:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y0+lHUof3gTnpFRsXZfsYTiGEvWvFcgVKpVyn63Gvs+uMDMJfZP/PFIfW2haUdaTewhUAMQSpHs0b9twGtggk5Iizfc39LjKqPiQj8/Z62NCaLZHMMpwln/ZwRchxnwe3M16+tSJuKTNmhxzBigJJTxQ2ixqhYaxq1THjXgF65A=
Message-ID: <9a8748490603060304q2fa22a4fq6d4abf1a8e990482@mail.gmail.com>
Date: Mon, 6 Mar 2006 12:04:33 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: Fw: Re: oops in choose_configuration()
Cc: "Greg KH" <greg@kroah.com>, torvalds@osdl.org,
       "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20060305154858.0fb0006a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060304121723.19fe9b4b.akpm@osdl.org>
	 <Pine.LNX.4.64.0603041235110.22647@g5.osdl.org>
	 <20060304213447.GA4445@kroah.com>
	 <20060304135138.613021bd.akpm@osdl.org>
	 <20060304221810.GA20011@kroah.com>
	 <20060305154858.0fb0006a.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/06, Andrew Morton <akpm@osdl.org> wrote:
>
> Might as well cc the list on this, so there's a record...
>
> For several days I've been getting repeatable oopses in the -mm kernel.
> They occur once per ~30 boots, during initscripts.
>
[snip]

Hi Andrew,

I send a mail to the list yesterday (with you and a few other people
on cc) about Slab corruption in 2.6.16-5c5-mm2.
You have a problem with memory corruption and I'm seeing slab
corruption messages in dmesg...

Just wanted to point it out in this thread in case they are related.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
