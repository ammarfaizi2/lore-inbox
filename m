Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423418AbWBBJeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423418AbWBBJeW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 04:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423416AbWBBJeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 04:34:22 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:3198 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423417AbWBBJeV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 04:34:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q9TLpuCnJBq1uD3ijejhUYl3I4JwGHTCp8ABm4I/kuuqAfZLcOIwj8mJDzSOBY1iDNqR1Rsj8BBB9Uo7D/ysRBOcKPW0hjY7HUG3ci2BJlUX8wRMBns2ir/skm69+vTJVfRjB0wSgYK5cMxq+fihwiWMpie66754d2jriqhDvzk=
Message-ID: <661de9470602020134i7f487717p6ed7641ec4d491bb@mail.gmail.com>
Date: Thu, 2 Feb 2006 15:04:18 +0530
From: Balbir Singh <bsingharora@gmail.com>
To: "linux@horizon.com" <linux@horizon.com>
Subject: Re: [PATCH 8/12] generic hweight{32,16,8}()
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       mita@miraclelinux.com
In-Reply-To: <20060131164949.3365.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060131164949.3365.qmail@science.horizon.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is an extremely well-known technique.  You can see a similar version
> that uses a multiply for the last few steps at
> http://graphics.stanford.edu/~seander/bithacks.html#CountBitsSetParallel
> whch refers to
> "Software Optimization Guide for AMD Athlon 64 and Opteron Processors"
> http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/25112.PDF
>
> It's section 8.6, "Efficient Implementation of Population-Count Function
> in 32-bit Mode", pages 179-180.

Thanks for doing this. The proof looks good except for what has been
already pointed out by Grant Grundler.
