Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030768AbWKUKDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030768AbWKUKDA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 05:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030803AbWKUKDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 05:03:00 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:28273 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030768AbWKUKC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 05:02:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ayncHnswc82KPMeol9WXR9Pz7YJ3WI+MA1iGjBttW0u+liqjstrE5H6XmnqFlh4BeocAiaBvJkgcNANdfl4DIJ6I3enK6g1vQ5RSf8wK99fw1NrQMevhIhSROJ7rqJbsbBFbrO9sCHSh+AJztk/AQebfPsoXw1D5tjdi0EwP0ow=
Message-ID: <4562CECB.5000107@gmail.com>
Date: Tue, 21 Nov 2006 19:02:51 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Dipti Ranjan Tarai <dipti@innomedia.soft.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to read/write from/to the HD with out kernel cashing
References: <4562CCB2.1030400@innomedia.soft.net>
In-Reply-To: <4562CCB2.1030400@innomedia.soft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipti Ranjan Tarai wrote:
> Hi all,
>       I am using fedora core -3 with kernel 2.6.10. I want to read/write 
> a sector from/to the HD with out kernel caching. Basically my aim is to 
> communicate directly with the ide drivers so that I can bypass the 
> kernel cache. Please give some idea regarding this.

man 2 open, then look for O_DIRECT.

-- 
tejun
