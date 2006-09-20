Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWITRmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWITRmf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWITRme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:42:34 -0400
Received: from smtp-out.google.com ([216.239.45.12]:19390 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932164AbWITRmd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:42:33 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=G9xtDlt/OsWOI+Oy/obgoextNMCTV8K1I9v5PtwYGUlw6UU0e5qQMaFoOL2pBWWQQ
	rYdENC+3u96a9sAGr6ghg==
Message-ID: <6599ad830609201042n7948a9e1s6cf70d0da04447f4@mail.google.com>
Date: Wed, 20 Sep 2006 10:42:24 -0700
From: "Paul Menage" <menage@google.com>
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Cc: "Rohit Seth" <rohitseth@google.com>, npiggin@suse.de, pj@sgi.com,
       linux-kernel <linux-kernel@vger.kernel.org>, devel@openvz.org,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.0609201035240.31464@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	 <1158773208.8574.53.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609201035240.31464@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/06, Christoph Lameter <clameter@sgi.com> wrote:
>
> I think we should have one container mechanism instead of multiple. Maybe
> merge the two? The cpuset functionality is well established and working
> right.

The basic container abstraction provided by cpusets is very nice -
maybe rename it from "cpuset" to "container"? Since it already
provides access to memory nodes as well as cpus, and could be extended
to handle other resource types too (network, disk).

Paul
