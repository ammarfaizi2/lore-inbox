Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310468AbSCGTVP>; Thu, 7 Mar 2002 14:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310478AbSCGTVD>; Thu, 7 Mar 2002 14:21:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10509 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310457AbSCGTUy>;
	Thu, 7 Mar 2002 14:20:54 -0500
Message-ID: <3C87BD22.BBBF4A86@zip.com.au>
Date: Thu, 07 Mar 2002 11:18:58 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, yodaiken@fsmlabs.com,
        Jeff Dike <jdike@karaya.com>, Benjamin LaHaise <bcrl@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages
In-Reply-To: <E16iz6l-0002St-00@the-village.bc.nu>,
		<E16iz6l-0002St-00@the-village.bc.nu> <E16izuL-000395-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> a GFP flag that says 'fail if this looks hard to get'.

Something like that would provide a solution to the
readahead thrashing problem.

-
