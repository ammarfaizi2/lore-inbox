Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946178AbWJTXoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946178AbWJTXoQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 19:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423250AbWJTXoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 19:44:16 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:51443 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1423239AbWJTXoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 19:44:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BfkUn6SagCUm64V3O0RwVCp7OGJBvCQCefslYrbLbzFrb/lZKqe+ti/0p4+Szebc4PyIlNVzCB9U8cHujIdKQpvdgQgJK3fyhxG3pBXhkI7sC82RFuqOQWk0+ODjaxzPtX5yyTzGL8REV/XN/e1r2PFf8E5u8ngy0QR4zMsWkow=
Message-ID: <f8912af80610201644x1a2b8c51l7eaabdd6a17828e5@mail.gmail.com>
Date: Sat, 21 Oct 2006 07:44:15 +0800
From: "Michael Ruan" <beceo.tw@gmail.com>
To: yh@bizmail.com.au
Subject: Re: kernel internal built in module loading order
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <f8912af80610201639u2949bc5fw2bad77311ffaf9d5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <453953EC.3000407@bizmail.com.au>
	 <f8912af80610201639u2949bc5fw2bad77311ffaf9d5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>Does the kernel load internal built in modules (obj-y) in a certain
>order, or in a random order? Does the kernel internal module loading
>based on a configuration file?
>I am running an ARM system, is there a way to delay the Ethernet module
>loading until some other internal modules are loaded?
>Thank you.

Yes, it follows some rules.

Please refer to the "3.2 Built-in object goals - obj-y" section of your
kernel_source_root/Documentation/kbuild/makefiles.txt

Michael
