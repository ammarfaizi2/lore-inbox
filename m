Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWAZDgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWAZDgF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWAZDgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:36:04 -0500
Received: from fmr22.intel.com ([143.183.121.14]:52110 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751312AbWAZDgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:36:01 -0500
Date: Wed, 25 Jan 2006 19:34:41 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Ashok Raj <ashok.raj@intel.com>, akpm@osdl.org, ak@muc.de,
       linux-kernel@vger.kernel.org, randy.d.dunlap@intel.com
Subject: Re: wrongly marked __init/__initdata for CPU hotplug
Message-ID: <20060125193440.A4205@unix-os.sc.intel.com>
References: <20060125120253.A30999@unix-os.sc.intel.com> <4496.1138242917@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4496.1138242917@ocs3.ocs.com.au>; from kaos@ocs.com.au on Thu, Jan 26, 2006 at 01:35:17PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 01:35:17PM +1100, Keith Owens wrote:
> Ashok Raj (on Wed, 25 Jan 2006 12:02:53 -0800) wrote:
> >There is 
> >one another about init/main.c that i cant exactly zero in. (partly 
> >because i dont know how to interpret the data thats spewed out of the tool).
> >
> >If there is a small example on how to co-related the data and find the culprit
> >would be real handy. 
> >
> >Maybe Keith could help parse/give an example for me.
> 
> # reference_init.pl
> Error: init/main.o .text refers to 00000000000001dc R_X86_64_PC32     .init.data+0x000000000000015b
> 

Awesome annotation... thanks very much keith... 
