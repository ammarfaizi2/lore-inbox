Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWEKSMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWEKSMn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 14:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWEKSMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 14:12:42 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:17927 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750709AbWEKSMl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 14:12:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JSrPhfP9ON58ReeEmveqx6DgXaQDgFmOzWdMX/J48a2VeU8TLM38vh/62Lj6EVwpUWj0Rnx3zRnCETstySBTczI+dzbN0ycckzS4bTSA0prcVArEoxWPfqcRYE1+qtbl+VoGUuzU2hRclAjgZgfaDq4zi0ZqJGxSS4H/aVTiDqg=
Message-ID: <9a8748490605111112h8fde257s3de1128ed95577b5@mail.gmail.com>
Date: Thu, 11 May 2006 20:12:41 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: + deprecate-smbfs-in-favour-of-cifs.patch added to -mm tree
Cc: akpm@osdl.org, sfrench@us.ibm.com, stable@kernel.org,
       urban@teststation.com, mm-commits@vger.kernel.org
In-Reply-To: <200605110717.k4B7HuVW006999@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605110717.k4B7HuVW006999@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/06, akpm@osdl.org <akpm@osdl.org> wrote:
>
> The patch titled
>
>      deprecate smbfs in favour of cifs
>
> has been added to the -mm tree.  Its filename is
>
>      deprecate-smbfs-in-favour-of-cifs.patch
>
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
>
>
> From: Andrew Morton <akpm@osdl.org>
>
> smbfs is a bit buggy and has no maintainer.  Change it to shout at the user on
> the first five mount attempts - tell them to switch to CIFS.
>
> Come November we'll mark it BROKEN and see what happens.
>
[snip]

Perhaps an addition to  Documentation/feature-removal-schedule.txt  is
also in order?

Something noting that it will be marked as broken in November and go
away some 12 - 18 months after that perhaps?


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
