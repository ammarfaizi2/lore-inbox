Return-Path: <linux-kernel-owner+w=401wt.eu-S1161200AbXAHKDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161200AbXAHKDx (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 05:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161203AbXAHKDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 05:03:53 -0500
Received: from wx-out-0506.google.com ([66.249.82.226]:26528 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161200AbXAHKDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 05:03:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G4vO78c9RUABJBEJm3ak10Xk7i+slw7ep/xk9WgWKS0va3lYMejDIWYi4CAkDQ5Cxy/54v9SujsuHGh3/B3aGvkHXeQ2ZEozxs0S2Wp7mr5+msFeAuB6u4XO57eOh4xwyETYbQrJF8CrOCprDBFDTWeOyJysatkWv5DXa7UJ30s=
Message-ID: <9a8748490701080203m383c99f0h1a2f32214a5e386e@mail.gmail.com>
Date: Mon, 8 Jan 2007 11:03:52 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: [PATCH] Remove a couple final references to obsolete verify_area().
Cc: "Linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       hskinnemoen@atmel.com
In-Reply-To: <Pine.LNX.4.64.0701071839560.18341@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0701071839560.18341@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/07, Robert P. J. Day <rpjday@mindspring.com> wrote:
>
>   Remove a couple final references to the obsolete verify_area() call,
> which was long ago replaced by access_ok().
>
> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
>
> ---
>
>   it *appears* that these last two references can be removed, unless
> there's something really strange i'm not seeing here.
>

The AVR32 code went in roughly a month after I did the last
verify_area() cleanup patch, so I missed these bits.
The patch looks sane to me, so feel free to add

Acked-by: Jesper Juhl <jesper.juhl@gmail.com>

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
