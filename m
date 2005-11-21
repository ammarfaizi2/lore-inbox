Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbVKUP6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbVKUP6e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 10:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbVKUP6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 10:58:34 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:45331 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932337AbVKUP6d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 10:58:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=puRphmyrt3BJKlFtvxhjxCUIhkBZo0FWLu/iKj6ihB70WGh74gHbMiJbMDz/2Jmpnf7WcuW8gIWh01abqqPbNWxKTxf6DNJj3ou+lBpxzWs080s+yMbRZ/U/vFU0cPcl0Mya20/51kCTraUUAwhRI2quhAZkbipOJYk7O/ak/2c=
Message-ID: <afcef88a0511210758t1a898933g9ebae1bbe3a29cca@mail.gmail.com>
Date: Mon, 21 Nov 2005 09:58:31 -0600
From: Michael Thompson <michael.craig.thompson@gmail.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 7/12: eCryptfs] File operations
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
In-Reply-To: <84144f020511190253p5f689346u8729bce45bd7df5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051119041130.GA15559@sshock.rn.byu.edu>
	 <20051119042029.GG15747@sshock.rn.byu.edu>
	 <84144f020511190253p5f689346u8729bce45bd7df5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/05, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> On 11/19/05, Phillip Hellewell <phillip@hellewell.homeip.net> wrote:
> > +/**
> > + * Opens the file specified by inode.
> > + *
> > + * @param inode        inode speciying file to open
> > + * @param file Structure to return filled in
> > + * @return Zero on success; non-zero otherwise
> > + */
>
> General comment: please use the kerneldoc format properly or don't use
> kerneldoc at all.

OK, this will be fixed for the next submission.

>
>                              Pekka
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
Michael C. Thompson <mcthomps@us.ibm.com>
Software-Engineer, IBM LTC Security
