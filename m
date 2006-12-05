Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031601AbWLEV3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031601AbWLEV3Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031615AbWLEV3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:29:24 -0500
Received: from wx-out-0506.google.com ([66.249.82.226]:11672 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031601AbWLEV3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:29:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gRwwsn9ILA2N7xzqjxizzwkHbVaVP497mxkuexhGqo3p+FvHy7KNdKohFZr7U72Brio4VhJHZ1XRopajLa8yfyMB45qYMLfQb+IJ3c2mnIy9g5xImm90J5RAFWhOfuOsBzCu+q6qf28dbP6W9b3WK1nObcj02R4dK7C54hTOua0=
Message-ID: <653402b90612051329r52f242e5k5987d54661dd38cb@mail.gmail.com>
Date: Tue, 5 Dec 2006 22:29:22 +0100
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: -mm merge plans for 2.6.20, scheduler bits
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20061205211723.GA7169@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061204204024.2401148d.akpm@osdl.org>
	 <20061205211723.GA7169@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> > kernel-schedc-whitespace-cleanups.patch
>
> Acked-by: Ingo Molnar <mingo@elte.hu>
>
> i dont like these:
>
> -               cost1 += measure_one(cache, size - i*1024, cpu1, cpu2);
> +               cost1 += measure_one(cache, size - i * 1024, cpu1, cpu2);
>
> as it's quite OK to have no spaces in "i*1024", just to indicate
> precedence of arithmetic ops. But the good bits dominate in this patch
> so lets have it and i'll undo the bad ones.
>

Ok, I will take care of that for future whitespace cleanups, as I see
they are welcome :)

-- 
Miguel Ojeda
http://maxextreme.googlepages.com/index.htm
