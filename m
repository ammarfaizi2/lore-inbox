Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266095AbTBGR3Y>; Fri, 7 Feb 2003 12:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266114AbTBGR3Y>; Fri, 7 Feb 2003 12:29:24 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:51905 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266095AbTBGR3X>;
	Fri, 7 Feb 2003 12:29:23 -0500
Date: Fri, 7 Feb 2003 17:35:16 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH] 2.5.59 : drivers/scsi/advansys.c
Message-ID: <20030207173516.GA31217@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Frank Davis <fdavis@si.rr.com>, linux-kernel@vger.kernel.org,
	trivial@rustcorp.com.au
References: <Pine.LNX.4.44.0302071223250.6917-100000@master>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302071223250.6917-100000@master>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2003 at 12:24:54PM -0500, Frank Davis wrote:

 >          if (scp->request_bufflen != 0 && qdonep->remain_bytes != 0 &&
 > -            qdonep->remain_bytes <= scp->request_bufflen != 0) {
 > +            qdonep->remain_bytes <= scp->request_bufflen && scp->request_bufflen!= 0) {

you now have two scp->request_bufflen != 0 checks.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
