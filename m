Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWI2QWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWI2QWi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 12:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWI2QWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 12:22:38 -0400
Received: from smtp-out.google.com ([216.239.45.12]:46838 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932322AbWI2QWh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 12:22:37 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=DbwZUuB692KOMWpbUBYNjxV+LDVS3CaCwN72janNQNK5tKIrJArX5PtOQVe9Z1jSj
	Apg9lh5LKgkXizbJi3zyQ==
Message-ID: <6599ad830609290922v3c1c0798wcf4ff16f0883884d@mail.google.com>
Date: Fri, 29 Sep 2006 09:22:23 -0700
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [RFC][PATCH 00/10] Task watchers v2 Introduction
Cc: "Matt Helsley" <matthltc@us.ibm.com>, linux-kernel@vger.kernel.org,
       jes@sgi.com, lse-tech@lists.sourceforge.net, sekharan@us.ibm.com,
       jtk@us.ibm.com, hch@lst.de, viro@zeniv.linux.org.uk, sgrubb@redhat.com,
       linux-audit@redhat.com
In-Reply-To: <20060928194142.cece62bb.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060929020232.756637000@us.ibm.com>
	 <20060928194142.cece62bb.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/06, Paul Jackson <pj@sgi.com> wrote:
> How might this play with Paul Menage's <menage@google.com> patch posted
> earlier today on lkml:
>
>   [RFC][PATCH 0/4] Generic container system

I've not looked closely at Matt's patch, but I'm sure that there would
be no problems with hooking the container system to use task watchers
rather than patching fork.c/exit.c directly.

Paul
