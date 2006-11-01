Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946653AbWKAHHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946653AbWKAHHy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 02:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946654AbWKAHHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 02:07:53 -0500
Received: from smtp-out.google.com ([216.239.33.17]:7978 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1946653AbWKAHHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 02:07:52 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=DuFgoV2eaiL+mn2PLzec8rhr7ASEb5+yYdzX83cKcIP/lsp/yN5BDL4OzzOdOZbKj
	YxbNkR3HBYTYRz0BoCP8A==
Message-ID: <6599ad830610312307i549f5a51h3b7a1744a14919f5@mail.gmail.com>
Date: Tue, 31 Oct 2006 23:07:40 -0800
From: "Paul Menage" <menage@google.com>
To: balbir@in.ibm.com
Subject: Re: [ckrm-tech] RFC: Memory Controller
Cc: dev@openvz.org, vatsa@in.ibm.com, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com
In-Reply-To: <4548472A.50608@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030103356.GA16833@in.ibm.com> <4545D51A.1060808@in.ibm.com>
	 <6599ad830610300304l58e235f7td54ef8744e462a55@mail.gmail.com>
	 <4545FDCD.3080107@in.ibm.com>
	 <6599ad830610301014l1bf78ce8q998229483d055a90@mail.gmail.com>
	 <454782D2.3040208@in.ibm.com>
	 <6599ad830610310922p61913cdaqb441a2cb718420a9@mail.gmail.com>
	 <4548472A.50608@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/06, Balbir Singh <balbir@in.ibm.com> wrote:
>
> I thought this would be hard to do in general, but with a page -->
> container mapping that will come as a result of the memory controller,
> will it still be that hard?

I meant that it's pretty much impossible with the current APIs
provided by the kernel. That's why one of the most useful things that
a memory controller can provide is accounting and limiting of page
cache usage.

Paul
