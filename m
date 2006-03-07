Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWCGVWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWCGVWT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 16:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWCGVWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 16:22:19 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:39590 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932302AbWCGVWT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 16:22:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TEo/dO69wIMKgSHgJOM6vnI4aEzvLkHKfpT4YlKev1elHpd9TYUhDV2r/MB7tEWlTRl1RJdS9P0GvG62zfP3V0dPgsbNPasEFmgfYMbOLG8RHbvI8VCKV2orq3q3Xwc1LLB1bWrHOa17CFhwtbJNykpvucGYFWG74TAa9JuB2SE=
Message-ID: <9a8748490603071322r624957c1ked074a7bf7263c20@mail.gmail.com>
Date: Tue, 7 Mar 2006 22:22:18 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.16-rc5-mm3
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060307021929.754329c9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060307021929.754329c9.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm3/
>

Just for the record; the slab corruption I was seeing with
2.6.16-rc5-mm2 does not occour with this kernel.
After a lot of rebuilds and very good bug hunting by various people we
found the offensive patch and it seems you removed it from -mm -
thanks.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
