Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWIVMD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWIVMD3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 08:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWIVMD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 08:03:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:46745 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932332AbWIVMD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 08:03:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=DhlLLOBlMaSoq4uHZA9Ox6xQe+XEfX15fDhZ+Gv3eJ2dlHJadwFbYsi5ASurZ+4BIcgheSAKAEJzEN9F5n4FEivuhUlYQEa7B3pi1bKjwexU1EQxG6VAygomWuTWaUD9UiTBvmwS25WzLQWhNAa6MPM86jkfPDYMrJ60wvkRIJQ=
Message-ID: <84144f020609220503n4c495542x2130165e371ec85c@mail.gmail.com>
Date: Fri, 22 Sep 2006 15:03:26 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Paulo Marques" <pmarques@grupopie.com>
Subject: Re: [KJ] kmalloc to kzalloc patches for drivers/block [sane version]
Cc: "Jiri Slaby" <jirislaby@gmail.com>, "Om Narasimhan" <om.turyx@gmail.com>,
       linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
In-Reply-To: <4513C9BF.7040706@grupopie.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6b4e42d10609202311t47038692x5627f51d69f28209@mail.gmail.com>
	 <20060921072017.GA27798@us.ibm.com>
	 <6b4e42d10609212240i3d02241djbdaa0176ab9bfb2b@mail.gmail.com>
	 <6b4e42d10609212304o52bbc9b4y434bbd7ef71281e3@mail.gmail.com>
	 <4513A21C.40704@gmail.com> <4513C9BF.7040706@grupopie.com>
X-Google-Sender-Auth: 3b5922a24e334c23
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/06, Paulo Marques <pmarques@grupopie.com> wrote:
> Agreed on every comment except this one. That complex expression is
> really just a constant in the end, so there is no point in using kcalloc.

The code is arguably easier to read with kcalloc.
