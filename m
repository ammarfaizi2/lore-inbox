Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162125AbWKPApA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162125AbWKPApA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 19:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162126AbWKPApA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 19:45:00 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:48845 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1162125AbWKPAo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 19:44:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=INp9fRGHdbet+e+SyFYSJkJjIYLS1btp4/+beer7xhQMe8vREvUW2jRJt6yVqrFhidq2G0TR0ZA0LAWe4c+rtNU75zWNRXtrSsOTztYfqkF2I8y4kg8mk82yzVNDNEiPmFvvDbuB6vevDdZSRgXlnSBEnSFWB1MLY3DwIND8+II=
Message-ID: <9a8748490611151644m5420fd9claf8212f98a6ad4e2@mail.gmail.com>
Date: Thu, 16 Nov 2006 01:44:58 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: [patch 2/2] enables booting a NUMA system where some nodes have no memory
Cc: "Martin Bligh" <mbligh@mbligh.org>, "Christian Krafft" <krafft@de.ibm.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0611151440400.23201@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061115193049.3457b44c@localhost>
	 <20061115193437.25cdc371@localhost>
	 <Pine.LNX.4.64.0611151323330.22074@schroedinger.engr.sgi.com>
	 <455B8F3A.6030503@mbligh.org>
	 <Pine.LNX.4.64.0611151440400.23201@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/06, Christoph Lameter <clameter@sgi.com> wrote:
> On Wed, 15 Nov 2006, Martin Bligh wrote:
>
> > A node is an arbitrary container object containing one or more of:
> >
> > CPUs
> > Memory
> > IO bus
> >
> > It does not have to contain memory.
>
> I have never seen a node on Linux without memory. I have seen nodes
> without processors and without I/O but not without memory.This seems to be
> something new?
>
What about SMP Opteron boards that have RAM slots for each CPU?
With two (or more) CPU's and only memory slots populated for one of
them, wouldn't that count as multiple NUMA nodes but only one of them
with memory?
That would seem to be a pretty common thing that could happen.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
