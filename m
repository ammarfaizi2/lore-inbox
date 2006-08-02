Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWHBXrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWHBXrD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 19:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWHBXrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 19:47:03 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:15011 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932227AbWHBXrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 19:47:01 -0400
Message-ID: <44D13980.1090604@engr.sgi.com>
Date: Wed, 02 Aug 2006 16:47:12 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: balbir@in.ibm.com, Shailabh Nagar <nagar@watson.ibm.com>,
       Jay Lan <jlan@sgi.com>, lkml <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@sgi.com>, Chris Sturtivant <csturtiv@sgi.com>,
       Tony Ernst <tee@sgi.com>
Subject: Re: [patch 1/3] add basic accounting fields to taskstats
References: <44CE57EF.2090409@sgi.com>	<44CF6433.50108@in.ibm.com>	<44CFCCE4.7060702@sgi.com>	<44D0C56C.3030505@watson.ibm.com>	<44D0DE13.7090205@in.ibm.com> <20060802140945.de650d95.akpm@osdl.org>
In-Reply-To: <20060802140945.de650d95.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>On Wed, 02 Aug 2006 22:47:07 +0530
>Balbir Singh <balbir@in.ibm.com> wrote:
>
>  
>>I am not sure if there is a version of BUG_ON() for compile time
>>asserts
>>    
>
>We have BUILD_BUG_ON()
>  

BUILD_BUG_ON() is a statement. I will do that inside bacct_add_tsk().

Thanks,
 - jay

