Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbVH3R6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbVH3R6f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 13:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbVH3R6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 13:58:35 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:48832 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932241AbVH3R6e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 13:58:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hvX7bnaM4qP4ik9Td0ZAY2pqdWPai9ri8M3P2TkJRzrnI/lZUeHJdRpu6ZruACp8j0ILEVxVenUIabM8TTqDZ2TXVh91AlsDzJRXLEA06xTh/3zW/w7OH1QNHJLtdgz2z6MAjHIYDyQUe+FNN+dcuMmgQza8FhZXo2FKD5dT7Wg=
Message-ID: <9a874849050830105826cd6c79@mail.gmail.com>
Date: Tue, 30 Aug 2005 19:58:31 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
Subject: Re: [PATCH] 2.6.13 - 1/3 - Remove the deprecated function __check_region
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200508301938.00044.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050830170502.GA10694@localhost.localdomain>
	 <9a874849050830101743c421db@mail.gmail.com>
	 <20050830172115.GA11784@localhost.localdomain>
	 <200508301938.00044.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
[snip]
> Here's a quick list of suspects for you :
> 
Just a quick note: don't forget that regions reserved with
request_region() have to be freed by release_region()  when no longer
needed.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
