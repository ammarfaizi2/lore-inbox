Return-Path: <linux-kernel-owner+w=401wt.eu-S1161054AbXALK1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161054AbXALK1H (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 05:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161060AbXALK1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 05:27:07 -0500
Received: from wx-out-0506.google.com ([66.249.82.239]:27535 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161054AbXALK1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 05:27:03 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RnbExX1/MWny3vV02bseMi/UD5HBbKmyiRt9ejOWS9jiyr5TTwLA2T6STra3A2S1ZmiGs9rAvLuk5VbBwz2nmq4bXaj9iAorcauDEiCl4SijUYO3W+mjAx+4CUIpQcQF10jx6SreateZKzsiqAknzZMruD8IHnQL8EGliiHOh78=
Message-ID: <9a8748490701120227h757d473ctaf5673aa318fe090@mail.gmail.com>
Date: Fri, 12 Jan 2007 11:27:01 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: congwen <congwen@gmail.com>
Subject: Re: How can I create or read/write a file in linux device driver?
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200701121547221465420@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200701121547221465420@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/07, congwen <congwen@gmail.com> wrote:
> Hello everyone, I want to create and read/write a file in Linux kernel or device driver,

Don't read/write user space files from kernel space.

Please search the archives, this get asked a lot and it has been
explained a million times why it's a bad idea.
You can also read http://www.linuxjournal.com/article/8110

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
