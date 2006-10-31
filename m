Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423531AbWJaQFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423531AbWJaQFL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423529AbWJaQFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:05:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:10075 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423531AbWJaQFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:05:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ROeY9rS/rVkqfjitzOzygRHKeD6qk2PYER96a6d8LiMt+9BLhKSgwc+tgTHkAFvWiLV7mmNDyKRGWragLOizN3oSKEKCsj+JkzqxuPeiB21yfm7wigv061DG9OEPlmnmkhFYps923/fF3W74tdtA8J/WlOCeIL4otjUJd/rDVwo=
Message-ID: <82ecf08e0610310805x6a77c2d3pd46eb2f76f75af67@mail.gmail.com>
Date: Tue, 31 Oct 2006 14:05:06 -0200
From: "Thiago Galesi" <thiagogalesi@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [ANNOUNCE] pahole and other DWARF2 utilities
Cc: "Arnaldo Carvalho de Melo" <acme@mandriva.com>,
       linux-kernel@vger.kernel.org, lwn@lwn.net
In-Reply-To: <20061030203334.09caa368.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030213318.GA5319@mandriva.com>
	 <20061030203334.09caa368.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >       Further ideas on how to use the DWARF2 information include tools
> > that will show where inlines are being used, how much code is added by
> > inline functions,
>
> It would be quite useful to be able to identify inlined functions which are
> good candidates for uninlining.
>
> -

Arnaldo, can't we get a call count for functions? (yes, it is not a
run-time call count, but rather, how many times the function if called
in the code) I guess this would help for this purpose of finding
candidates for inlining, uninlining.

-- 
-
Thiago Galesi
