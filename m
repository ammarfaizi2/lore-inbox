Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWHITOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWHITOQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 15:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWHITOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 15:14:16 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:6392 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751261AbWHITOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 15:14:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=rIiUyclDYdsjNwDTGMdTnZjj74Hwdw87cHlHrcGuHqF6Z4OrFaRQRTzpUpqRaZ4I607wFcoCyB39/pvroWwH5PVDDgFlXRaK72XD8ibUJPE0Z3m37TioKCh6NreX7Pn5F7eK7GQTlmZpkV+Q99TX4QusT5NUpnbuWA+EEwk4I4c=
Message-ID: <84144f020608091214n5cf74b89pb036e7c42a4eb364@mail.gmail.com>
Date: Wed, 9 Aug 2006 22:14:14 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Re: [RFC/PATCH] revoke/frevoke system calls V2
Cc: "Edgar Toernig" <froese@gmx.de>, "Pavel Machek" <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org, viro@zeniv.linux.org.uk, tytso@mit.edu,
       tigran@veritas.com
In-Reply-To: <1155148549.5729.249.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	 <20060805122936.GC5417@ucw.cz> <20060807101745.61f21826.froese@gmx.de>
	 <84144f020608070251j2e14e909v8a18f62db85ff3d4@mail.gmail.com>
	 <20060807224144.3bb64ac4.froese@gmx.de>
	 <1155040157.5729.34.camel@localhost.localdomain>
	 <20060809104155.48ad3c77.froese@gmx.de>
	 <1155120128.5729.143.camel@localhost.localdomain>
	 <20060809200019.0bd5eecd.froese@gmx.de>
	 <1155148549.5729.249.camel@localhost.localdomain>
X-Google-Sender-Auth: 02edeac4a68f1a08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> I can see your concern about arbitary files, but I'm not sure it holds
> simply because the tricks already exist via other methods.

Agreed. We should support close(2) and munmap(2), though.
