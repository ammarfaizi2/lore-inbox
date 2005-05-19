Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVESLQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVESLQO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 07:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVESLQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 07:16:14 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:16345 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261799AbVESLQK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 07:16:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rryFMD/ndOAoxN8c1/yS+O/dlncZMo4shIJqe0+lZaEVordWGncFQFEfNaPGPO5gN4FErhst+qsDyGoxRi26W6tMGZ8dBY+hOUKOHJcVq9mQSdim9aOXvVhpIBgKIm6zEuk1/TxvcPzA5uLV4XDlz6QtzCDk7oShq0c/gRBR5HQ=
Message-ID: <73e1f59805051904167a36bc0f@mail.gmail.com>
Date: Thu, 19 May 2005 13:16:10 +0200
From: =?WINDOWS-1252?Q?Lubo=9A_Dole=9Eel?= <lubosd@gmail.com>
Reply-To: =?WINDOWS-1252?Q?Lubo=9A_Dole=9Eel?= <lubosd@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: "loop device recursion avoidance" patch causes difficulties
In-Reply-To: <20050518140440.415228e5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <73e1f59805051704216bc4c78f@mail.gmail.com>
	 <20050518140440.415228e5.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/05, Andrew Morton <akpm@osdl.org> wrote:
> Lubo_ Dole_el <lubosd@gmail.com> wrote:
> >
> > I've created a bugreport at http://bugme.osdl.org/show_bug.cgi?id=4472
> > and I was advised to write to this list.
> >
> > A patch called "loop device recursion avoidance" which appeared in
> > 2.6.11 kernel has complicated ISO image mounting from another mounted
> > media.
> 
> Does this help?
>  

It didn't help. And I've realized a big mistake. I tried to mount the
DVD without supermount. And it worked. So this is a problem in
supermount patch.
Sorry for bothering you :-( and thanks anyway.
