Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261457AbSJQPB7>; Thu, 17 Oct 2002 11:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261459AbSJQPB7>; Thu, 17 Oct 2002 11:01:59 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:50189 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261457AbSJQPB7>;
	Thu, 17 Oct 2002 11:01:59 -0400
Date: Thu, 17 Oct 2002 08:07:41 -0700
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Cc: crispin@wirex.com
Subject: Re: [PATCH] make LSM register functions GPLonly exports
Message-ID: <20021017150740.GA31056@kroah.com>
References: <20021017153505.A27998@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017153505.A27998@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 03:35:05PM +0100, Christoph Hellwig wrote:
> These exports have the power to change the implementations of all
> syscalls and I've seen people exploiting this "feature".
> 
> Make the exports GPLonly (which some LSM folks agreed to
> when it was merged initially to avoid that).

I would really, really, really like to make this change.  Unfortunatly,
one of the current copyright holders of this file does not agree with
it.

Crispin, for the benifit of the lkml readers, can you explain why WireX
does not want this change?

thanks,

greg k-h
