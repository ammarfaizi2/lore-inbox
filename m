Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161334AbWJ3RzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161334AbWJ3RzI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 12:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161337AbWJ3RzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 12:55:07 -0500
Received: from smtp-out.google.com ([216.239.45.12]:28504 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1161334AbWJ3RzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 12:55:05 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=XXAN0zclkJ7j998+MmH3U15Vpjkm1uiCmn8tu55q4qN9hb3Rua6HxINAhb4P3Szsi
	JOAJ7xm0e5j/pPOMygb+A==
Message-ID: <6599ad830610300953o7cbf5a6cs95000e11369de427@mail.gmail.com>
Date: Mon, 30 Oct 2006 09:53:28 -0800
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Cc: dev@openvz.org, vatsa@in.ibm.com, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
In-Reply-To: <20061030042714.fa064218.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030103356.GA16833@in.ibm.com>
	 <6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com>
	 <20061030031531.8c671815.pj@sgi.com>
	 <6599ad830610300404v1e036bb7o7ed9ec0bc341864e@mail.gmail.com>
	 <20061030042714.fa064218.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/06, Paul Jackson <pj@sgi.com> wrote:
>
> You mean let the system admin, say, of a system determine
> whether or not CKRM/RG and cpusets have one shared, or two
> separate, hierarchies?

Yes - let the sysadmin define the process groupings, and how those
groupings get associated with resource control entities. The default
should be that all the hierarchies are the same, since I think that's
likely to be the common case.

Paul
