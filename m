Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289781AbSAOX5e>; Tue, 15 Jan 2002 18:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290267AbSAOX4W>; Tue, 15 Jan 2002 18:56:22 -0500
Received: from ns.suse.de ([213.95.15.193]:48909 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289779AbSAOXy4>;
	Tue, 15 Jan 2002 18:54:56 -0500
Date: Wed, 16 Jan 2002 00:54:50 +0100
From: Dave Jones <davej@suse.de>
To: =?iso-8859-1?Q?Peter_W=E4chtler?= <pwaechtler@loewe-komp.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oopses in scheduler on Linux-2.4.17-xfs
Message-ID: <20020116005450.K32088@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	=?iso-8859-1?Q?Peter_W=E4chtler?= <pwaechtler@loewe-komp.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C44B260.D1FA47BF@loewe-komp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C44B260.D1FA47BF@loewe-komp.de>; from pwaechtler@loewe-komp.de on Tue, Jan 15, 2002 at 11:51:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 11:51:12PM +0100, Peter Wächtler wrote:
 > 
 > I recently get oopses on 2.4.14-xfs and 2.4.17-xfs.
 > box is SMP with old Pentium Pro
 > There were some changes with erratas of the Pro ans something
 > with "cacheline alignment" and a fence.

 In 2.4.14, the errata workaround wasn't even activated.
 The cacheline alignment should cause anything like this either.

 Can you repeat without xfs, kdb and whatever else you have
 compiled in ?

 Dave.
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
