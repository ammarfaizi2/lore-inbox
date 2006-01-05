Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWAEVRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWAEVRu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWAEVRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:17:50 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:51718 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932217AbWAEVRt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:17:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ELbOcw5oQZYnTQa8WOmdnrhUGuGJiiUV3c0e3FlU2qdoiSyX4M00IBqGv6PV8txVZlQgS67kTnysDM0idr8PchyM18fsTqXrDpaUZ7fRzZ1C/gKk8C8AGkLF3WRNuAOF+8tDQFSQjMjaAicXF2cybJFwB5tQTjKRqBclQeeAVug=
Message-ID: <728201270601051317s2fd8f9aeh7d5772dc4dbe54af@mail.gmail.com>
Date: Thu, 5 Jan 2006 15:17:38 -0600
From: Ram Gupta <ram.gupta5@gmail.com>
To: jeff shia <tshxiayu@gmail.com>
Subject: Re: what is the state of current after an mm_fault occurs?
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <7cd5d4b40601041920u596551d2h75e167311e9452e4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7cd5d4b40601040240n79b2d654t33424e91059988a9@mail.gmail.com>
	 <20060104174808.7b882af8.akpm@osdl.org>
	 <7cd5d4b40601041920u596551d2h75e167311e9452e4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/06, jeff shia <tshxiayu@gmail.com> wrote:
> en,
>  You mean in some pagefault place we do schedule()?
>   Where?
>   Thank you !

It used to be in earlier kernel at least in 2.5.45 version  .It is
called from pte_alloc_one when it fails to allocate page & waits by
calling schedule_timeout.


Ram
