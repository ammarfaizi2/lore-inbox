Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318075AbSGWPFW>; Tue, 23 Jul 2002 11:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318097AbSGWPFU>; Tue, 23 Jul 2002 11:05:20 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:32523 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318075AbSGWPDt>; Tue, 23 Jul 2002 11:03:49 -0400
Date: Tue, 23 Jul 2002 16:06:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: axel@hh59.org, linux-kernel@vger.kernel.org,
       jfs-discussion@www-124.ibm.com
Subject: Re: [Jfs-discussion] Re: 2.5.27: Software Suspend failure / JFS errors
Message-ID: <20020723160657.A23708@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Kleikamp <shaggy@austin.ibm.com>, axel@hh59.org,
	linux-kernel@vger.kernel.org, jfs-discussion@oss.software.ibm.com
References: <20020721122932.GA23552@neon.hh59.org> <20020721144212.GA23767@neon.hh59.org> <200207230954.36039.shaggy@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207230954.36039.shaggy@austin.ibm.com>; from shaggy@austin.ibm.com on Tue, Jul 23, 2002 at 09:54:35AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 09:54:35AM -0500, Dave Kleikamp wrote:
> On Sunday 21 July 2002 09:42, axel@hh59.org wrote:
> > This oops occurred during build of gcc..
> > Kernel 2.4.19-rc2-ac2.
> > About the same happens with 2.5.27. I will post an oops of jfsCommit
> > of 2.5.27 as soon as I get one.
> 
> I just built gcc on 2.4.19-rc3 + latest JFS and didn't have a problem.  
> I'll repeat it on 2.4.19-rc2-ac2, but there shouldn't be more than a 
> comsmetic difference in the JFS code.  I haven't tried 2.5.27 yet.

As I read 'Software Suspend' in the subject I guess it's swsusp fault.
Swsusp needs magic flags for kernel threads which no one has added to
JFS yet.

