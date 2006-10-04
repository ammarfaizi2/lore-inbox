Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWJDVm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWJDVm4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWJDVmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:42:55 -0400
Received: from smtp-out.google.com ([216.239.33.17]:33593 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751165AbWJDVmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:42:54 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=fOH26ObU8duXHaK62xj3ZrbDPA2UTXdC1SvRdJ7yGgaOV7W3opcmq9IdYtNDxsvl2
	32A9XopLXka7u3jGSeo6w==
Message-ID: <6599ad830610041442t14b627bbs7b37c98b1e10852c@mail.gmail.com>
Date: Wed, 4 Oct 2006 14:42:39 -0700
From: "Paul Menage" <menage@google.com>
To: sekharan@us.ibm.com
Subject: Re: [RFC][PATCH 0/4] Generic container system
Cc: "Martin Bligh" <mbligh@google.com>, pj@sgi.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       winget@google.com, rohitseth@google.com, jlan@sgi.com,
       Joel.Becker@oracle.com, Simon.Derr@bull.net
In-Reply-To: <1159997821.24266.62.camel@linuxchandra>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061002095319.865614000@menage.corp.google.com>
	 <1159925752.24266.22.camel@linuxchandra>
	 <6599ad830610031934s41994158o59f1a2e58b1cb45e@mail.gmail.com>
	 <1159988217.24266.60.camel@linuxchandra> <45240D20.3080202@google.com>
	 <1159997821.24266.62.camel@linuxchandra>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/06, Chandra Seetharaman <sekharan@us.ibm.com> wrote:
> > All of this (and the rest of the snipped email with suggested
> > improvements) makes pretty good sense. But would it not be better
> > to do this in stages?
> >
> > 1) Split the code out from cpusets
>
> Paul (Menage) is already work on this.

The split out is done - right now I'm tidying up an example of RG
moved over the container API - basically dumping the group membership
code (since container.c supplies that) and migrating the shares/stats
file model to containerfs rather than configfs. I'll try to send it
out today.

Paul
