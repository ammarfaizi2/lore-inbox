Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288979AbSAITty>; Wed, 9 Jan 2002 14:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288981AbSAITtf>; Wed, 9 Jan 2002 14:49:35 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:31216 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S288979AbSAITtX>; Wed, 9 Jan 2002 14:49:23 -0500
Date: Wed, 9 Jan 2002 14:49:19 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br, andrea@suse.de
Subject: Re: [PATCH] PAGE_SIZE IO for RAW (RAW VARY)
Message-ID: <20020109144919.E12609@redhat.com>
In-Reply-To: <20020109132148.C12609@redhat.com> <200201091928.g09JSdH23535@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200201091928.g09JSdH23535@eng2.beaverton.ibm.com>; from pbadari@us.ibm.com on Wed, Jan 09, 2002 at 11:28:39AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 11:28:39AM -0800, Badari Pulavarty wrote:
> Ben,
> 
> By any chance do you have a list of drivers that assume this ? 
> What does it take to fix them ? 

No, doing the audit *is* the hard work in creating a patch like this.

> If it is not reasonable to fix all the brokern drivers,
> how about making this configurable (to do variable size IO) ?
> Do you favour this solution ?

How does that solve anything?  There is no way for a user to be even 
remotely confident that enabling the option will not corrupt data.  As 
a distributor, that makes it impossible to enable.  As a developer, 
that's just unsound practice.

		-ben
--
Blue.
