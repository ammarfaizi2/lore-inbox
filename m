Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262921AbTJTVMZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 17:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbTJTVMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 17:12:25 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:45806 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262921AbTJTVMY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 17:12:24 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Karl Vogel <karl.vogel@seagha.com>, linux-kernel@vger.kernel.org
Subject: Re: LVM on md0: raid0_make_request bug: can't convert block across chunks or bigger than 64k
Date: Mon, 20 Oct 2003 16:06:09 -0500
User-Agent: KMail/1.5
References: <1066682115.1799.15.camel@kvo.local.org>
In-Reply-To: <1066682115.1799.15.camel@kvo.local.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310201606.09098.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 October 2003 15:35, Karl Vogel wrote:
> I'm getting the following kernel messages on V2.6.0-test8-mm1 (I've also
> tried plain -test7 and some kernels before that) when copying moderately
> sized files from a raid-0/LVM volume:
>
> --- snip ---
> raid0_make_request bug: can't convert block across chunks or bigger than
> 64k 24081064 64
> raid0_make_request bug: can't convert block across chunks or bigger than
> 64k 24080656 64
> raid0_make_request bug: can't convert block across chunks or bigger than
> 64k 24080784 64
> raid0_make_request bug: can't convert block across chunks or bigger than
> 64k 24080928 64

Looks like this was just recently fixed on the linux-raid list.

http://marc.theaimsgroup.com/?l=linux-raid&m=106661294929434

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/

