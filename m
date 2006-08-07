Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWHGJvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWHGJvI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 05:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWHGJvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 05:51:07 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:52518 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750737AbWHGJvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 05:51:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=fdN2ijy3xAOOluN5JF76whmELXrVRZY/WOUjIMdk+yAX5orC7FJoAmFA4rdriw6DnrRKtGukhQOeaHz4k4O39UwC542STWp+Q+LXqafxp/vm168lCID0hN2fJjtlb0gX41nKaZ9XAj5Bo6gWHSgY7eo50zppVzUu/O1aq5JDfa0=
Message-ID: <84144f020608070251j2e14e909v8a18f62db85ff3d4@mail.gmail.com>
Date: Mon, 7 Aug 2006 12:51:02 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Edgar Toernig" <froese@gmx.de>
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
Cc: "Pavel Machek" <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       alan@lxorguk.ukuu.org.uk, tytso@mit.edu, tigran@veritas.com
In-Reply-To: <20060807101745.61f21826.froese@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	 <20060805122936.GC5417@ucw.cz> <20060807101745.61f21826.froese@gmx.de>
X-Google-Sender-Auth: 34c81c86db8ce63e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/06, Edgar Toernig <froese@gmx.de> wrote:
> Why do we need [f]revoke at all?  As it doesn't implement the
> BSD semantic I can't see why it's better than fuser -k.

Which part of the BSD semantics is that?
