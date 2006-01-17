Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWAQKwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWAQKwV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 05:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWAQKwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 05:52:21 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:53121 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932386AbWAQKwU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 05:52:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OmuOHmaNEEOT54uNgs+qqhrw1J8BG+hY8+gM4m79YL2R6/wVGohZCobvKJ5VtMQipZl0RQWVPngnF4ZvZjmkur+RCem6xcTv5e8IrHkdeWXjZ7o+Rf51G8tcC1g+3VkvWXC9IAi4X2J/Gqqu3dGQxvPqgsSK6COJ1ztrdguKzW8=
Message-ID: <9a8748490601170252g1a89262n2745ef5bb3e1b16f@mail.gmail.com>
Date: Tue, 17 Jan 2006 11:52:19 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Keith Owens <kaos@ocs.com.au>
Subject: Re: [PATCH 3/4] compact print_symbol() output
Cc: Akinobu Mita <mita@miraclelinux.com>, ak@suse.de,
       linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <10099.1137494043@ocs3.ocs.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060117101555.GD19473@miraclelinux.com>
	 <10099.1137494043@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/06, Keith Owens <kaos@ocs.com.au> wrote:
> Akinobu Mita (on Tue, 17 Jan 2006 19:15:55 +0900) wrote:
> >- remove symbolsize field
> >- change offset format from hexadecimal to decimal
>
> That is silly.  Almost every binutils tool prints offsets in hex,
> including objdump and gdb.  Printing the trace offset in decimal just
> makes more work for users to convert back to decimal to match up with
> all the other tools.
>
Agreed.
Also, hex output is shorter and often more natural for this type of data.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
