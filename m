Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317390AbSHBBIF>; Thu, 1 Aug 2002 21:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317484AbSHBBIF>; Thu, 1 Aug 2002 21:08:05 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:60886 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317390AbSHBBIE>; Thu, 1 Aug 2002 21:08:04 -0400
Date: Thu, 01 Aug 2002 18:09:50 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
cc: "Seth, Rohit" <rohit.seth@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: Re: large page patch
Message-ID: <737220000.1028250590@flay>
In-Reply-To: <3D49D45A.D68CCFB4@zip.com.au>
References: <3D49D45A.D68CCFB4@zip.com.au>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - The change to MAX_ORDER is unneeded

It's not only unneeded, it's detrimental. Not only will we spend more
time merging stuff up and down to no effect, it also makes the 
config_nonlinear stuff harder (or we have to #ifdef it, which just causes
more unnecessary differentiation). Please don't do that little bit ....

M.


