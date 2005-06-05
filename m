Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVFEVvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVFEVvM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 17:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVFEVvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 17:51:12 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:5015 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261611AbVFEVvJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 17:51:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WgGmWwjKOd6MIYtpYvuE9KszRUHBOaC7keSGEQssy8DGGrNZqFZO3t54DPYNOhR7aeK54VxwBgS08m0c3rsCcjVCu4KvBapaBXYLdCcYS6n25t0sZ5fxfyCbZk1QUZPVc+RUaKBtOfCJa3YYJNfmNATajjHaKxKniqLJ0a4xXLs=
Message-ID: <9a87484905060514517fa99047@mail.gmail.com>
Date: Sun, 5 Jun 2005 23:51:08 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver
Cc: Abhay Salunke <Abhay_Salunke@dell.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, matt_domsch@dell.com,
       Greg KH <greg@kroah.com>
In-Reply-To: <1117756728.3656.45.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050602232634.GA32462@littleblue.us.dell.com>
	 <1117756728.3656.45.camel@pegasus>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Abhay,
> 
> > Resubmitting after cleaning up spaces/tabs etc...
> 
> and now starting with the coding style nitpicking ;)
> 
[snip]
> > +     if (pbuf != NULL) {
> 
> Make it "if (!pbuf)",
> 
[snip]

You want to make it  "if (pbuf)"  otherwise you'd be changing the logic.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
