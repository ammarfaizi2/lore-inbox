Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWG0Rou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWG0Rou (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 13:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWG0Rou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 13:44:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:44566 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750813AbWG0Rot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 13:44:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HUDbD+FKUweOin97TxXFFJGr0nZwozzcPrPxXen4PwoCgixdQNzEQt7iiUNS+lsrirVsfTaiPQiIKHJecZiWvqUtNsz/+D6MsiiZdFKWW+DbQiWb8HDGL4WZx3v+i6LE2ValU5o84isFpJ8kbcLwCbP2x2Ay5MoTeNxhfYxAg8c=
Message-ID: <a36005b50607271044s28ecd6f5r80ef4d30e317cc6e@mail.gmail.com>
Date: Thu, 27 Jul 2006 10:44:47 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
Cc: "Pekka J Enberg" <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       alan@lxorguk.ukuu.org.uk, tytso@mit.edu, tigran@veritas.com
In-Reply-To: <44C8F8F3.2090606@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	 <a36005b50607270941n187e8b06ga9b1b6454cf2e548@mail.gmail.com>
	 <Pine.LNX.4.58.0607272004270.7152@sbz-30.cs.Helsinki.FI>
	 <a36005b50607271013o3c03238fq4ecea87dcd3c1e90@mail.gmail.com>
	 <44C8F8F3.2090606@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/06, H. Peter Anvin <hpa@zytor.com> wrote:
> No need to add sys_revoke.

Of course not.  I didn't imply that.  sys_revokeat is all that's
needed.  I just provided the other name to make clear they are
equivalent wrt to the file name property.  Not everyone knows the *at
functions.
