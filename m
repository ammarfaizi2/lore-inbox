Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWESWns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWESWns (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 18:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWESWns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 18:43:48 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:11070 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751377AbWESWnr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 18:43:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lhqqY4q7EIBK3PmrzwCeIeUkhrOQrlkbQfvwWRwUu7sf53E8Qa+atzagmhQQw7StsVXB+KQkETfO3OlGM6h8bSnkdCwH1tFm3AJad6mNxOShS7IKErL3AdlUYP+hOk+p4nHvnPqfOiXAYPgHDXPhrrPjQbvb8Hdfomz8Ufnga1k=
Message-ID: <7e90c9180605191543s28409521h4d59897d6bbdb643@mail.gmail.com>
Date: Fri, 19 May 2006 15:43:45 -0700
From: "Peter Gordon" <codergeek42@gmail.com>
To: "=?ISO-8859-1?Q?D=F6hr,_Markus_ICC-H?=" 
	<Markus.Doehr@siegenia-aubi.com>
Subject: Re: replacing X Window System !
Cc: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <FC7F4950D2B3B845901C3CE3A1CA6766012A9E6F@mxnd200-9.si-aubi.siegenia-aubi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <FC7F4950D2B3B845901C3CE3A1CA6766012A9E6F@mxnd200-9.si-aubi.siegenia-aubi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Although one has to admit that working with remote X terminals over a
> SSH/WAN/VPN-connection is far from usefull, [...]
You can tunnel just about anything X11 over SSH/VPN/etc.; even things
like a whole desktop GUI; not just plain X terminals.

> However, there´s NX (http://www.nomachine.com/) and
> other products but out of the box X11 it´s quite slow over higher latency
> connections.
One good way to reduce latency (at least when using X11 over SSH) is
to tell SSH to compress its connection tunnel ("ssh -C ...").
