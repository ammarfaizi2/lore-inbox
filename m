Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWGSCsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWGSCsV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 22:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWGSCsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 22:48:21 -0400
Received: from web60412.mail.yahoo.com ([209.73.178.155]:6241 "HELO
	web60412.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932452AbWGSCsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 22:48:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=JRbZeHaPXmJh5PBaEBZhC1n1zLEsWTIJExFLcsvmVPSuCtNCLQyEmMVv3ENq+OLvcpYphNiZw+iDlWWz5R1HQwLAEURPrrhfaIOTBJnuykCpTIYnoS7C7qJAGzaxinmtCqGENMpK74f7rt+sBnnZiO1UDTTHeFOBmcv4QECq0ik=  ;
Message-ID: <20060719024819.25960.qmail@web60412.mail.yahoo.com>
Date: Tue, 18 Jul 2006 19:48:19 -0700 (PDT)
From: Pete Zaitcev <zaitcev@yahoo.com>
Subject: Re: [PATCH] sound: Conversions from kmalloc+memset to k(z|c)alloc.
To: Panagiotis Issaris <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org
Cc: kyle@parisc-linux.org, twoller@crystal.cirrus.com,
       James@superbug.demon.co.uk, zab@zabbo.net, sailer@ife.ee.ethz.ch,
       perex@suse.cz, zaitcev@yahoo.com
In-Reply-To: <20060719005455.GB30823@lumumba.uhasselt.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Panagiotis Issaris <takis@lumumba.uhasselt.be> wrote:

> sound: Conversions from kmalloc+memset to k(c|z)alloc.
> 
> Signed-off-by: Panagiotis Issaris <takis@issaris.org>

>  sound/oss/ymfpci.c              |    6 ++----

I can't fathom why you would want to bother. These drivers are going to
be removed from tree anyway. Where is Adrian when you actually need him?

-- Pete


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
