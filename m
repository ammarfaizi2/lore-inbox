Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWIUALG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWIUALG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWIUALG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:11:06 -0400
Received: from smtp-out.google.com ([216.239.45.12]:3889 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750802AbWIUALE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:11:04 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=wcpV+lS1OlWweIJ98bl/KlTMeyrEGxTQMcduUza4Eirn71syD4rY6nNl1p2MRKzMt
	GFbXFYh5mAuaQ+XlgodHw==
Message-ID: <6599ad830609201710q4ab1cd18lf4ef3c6534e06338@mail.google.com>
Date: Wed, 20 Sep 2006 17:10:52 -0700
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Cc: alan@lxorguk.ukuu.org.uk, clameter@sgi.com, npiggin@suse.de,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, devel@openvz.org
In-Reply-To: <20060920170759.c31c0596.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	 <1158773699.7705.19.camel@localhost.localdomain>
	 <6599ad830609201030w38b6ae59ia0d4a4ccabb47054@mail.google.com>
	 <20060920163722.1442c5c1.pj@sgi.com>
	 <6599ad830609201653g4f44a4frb308eaeb63f83d2a@mail.google.com>
	 <20060920170759.c31c0596.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/06, Paul Jackson <pj@sgi.com> wrote:
> Some of the file system folks have considered such use of extended
> attributes, yes.
>
> I remain unaware that any relation between that work and cpusets
> exists or should exist.

It doesn't have to be linked to cpusets - but userspace could use it
in conjunction with cpusets to control/account pagecache memory
sharing.

Paul
