Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318324AbSIFALn>; Thu, 5 Sep 2002 20:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318345AbSIFALn>; Thu, 5 Sep 2002 20:11:43 -0400
Received: from mout0.freenet.de ([194.97.50.131]:20703 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S318324AbSIFALl>;
	Thu, 5 Sep 2002 20:11:41 -0400
Date: Fri, 6 Sep 2002 02:16:02 +0200
From: Axel Siebenwirth <axel@hh59.org>
To: Christoph Hellwig <hch@infradead.org>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       JFS-Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       linux-kernel@vger.kernel.org
Cc: rml@tech9.net, akpm@zip.com.au
Subject: Re: [OOPS:2.5.33] Re: [Jfs-discussion] crash with JFS assert
Message-ID: <20020906001602.GA393@prester.freenet.de>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Kleikamp <shaggy@austin.ibm.com>,
	JFS-Discussion <jfs-discussion@www-124.ibm.com>,
	linux-kernel@vger.kernel.org, rml@tech9.net, akpm@zip.com.au
References: <Pine.LNX.4.43.0209051006480.887-100000@leo.uni-sw.gwdg.de> <3D771308.6030009@hh59.org> <200209050755.06015.shaggy@austin.ibm.com> <20020906000040.GA269@prester.freenet.de> <20020906000250.GB269@prester.freenet.de> <20020906010641.A24706@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020906010641.A24706@infradead.org>
Organization: hh59.org
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph!

On Fri, 06 Sep 2002, Christoph Hellwig wrote:

> This is 2.5.33 + akpm's patchkit, right?  CONFIG_PREEMPT worries me,
> although I wonder whether JFS might be affected by similar problem NFS
> is, although I can't see any relation.

Yes. It's 2.5.33 + 2.5.33-mm2 (by Andrew Morton [is that what you meant?]).

Aaaah! I got it. I just wanted to write an email expressing that for some
strange reason latest 2.4 kernels (2.4.19-ac4, 2.4.20-pre5+latest ACPI)
work without a problem.
You know what the difference to my 2.5 kernels is..... CONFIG_PREEMPT is not
enabled with my 2.4 kernels but with 2.5 it is!

Here we go.

Maybe someone can now get an idea on what the problem is and maybe how to
fix it?!

My best regards,
Axel Siebenwirth
