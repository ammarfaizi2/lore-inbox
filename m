Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751888AbWJMXrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbWJMXrY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 19:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002AbWJMXrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 19:47:24 -0400
Received: from smtp-out.google.com ([216.239.33.17]:24053 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751888AbWJMXrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 19:47:23 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=QxQCNOtDNMh5KHTLU4s7d/bInFfSA5Xdtr2G0tjQY2tSO42H9pPEWo3sWbizS5njS
	D35ojJhTakkGIswo69nBg==
Message-ID: <6599ad830610131647p5427b57aq6a6e91b860e093df@mail.gmail.com>
Date: Fri, 13 Oct 2006 16:47:17 -0700
From: "Paul Menage" <menage@google.com>
To: "Matt Helsley" <matthltc@us.ibm.com>
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in configfs
Cc: "Greg KH" <greg@kroah.com>, ckrm-tech@lists.sourceforge.net,
       "Chandra Seetharaman" <sekharan@us.ibm.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1160782808.18766.553.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
	 <20061010203511.GF7911@ca-server1.us.oracle.com>
	 <6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com>
	 <20061010215808.GK7911@ca-server1.us.oracle.com>
	 <1160527799.1674.91.camel@localhost.localdomain>
	 <20061011012851.GR7911@ca-server1.us.oracle.com>
	 <20061011223927.GA29943@kroah.com>
	 <1160609160.6389.80.camel@linuxchandra>
	 <20061012235127.GA15767@kroah.com>
	 <1160782808.18766.553.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/06, Matt Helsley <matthltc@us.ibm.com> wrote:
> On Thu, 2006-10-12 at 16:51 -0700, Greg KH wrote:
>
> <snip>
>
> > > BTW, it it not just CKRM/RG, Paul Menage as recently extracted the
> > > processes aggregation from cpuset to have an independent infrastructure
> > > (http://marc.theaimsgroup.com/?l=ckrm-tech&m=116006307018720&w=2), which
> > > has its own file system. I was advocating him to use configfs. But, he
> > > also has this issue/limitation.
> >
> > That's one reason it is so easy to just write your own filesystem then.
> > What is it these days, less than 200 lines of code?  I bet you can even
>
> For my_school_project_fs perhaps 200 lines is sufficient.
>
> Paul Menage's patch which Chandra was referring to:
>
> http://lkml.org/lkml/2006/9/28/104
>
> is 1700 insertions.

To be fair, only about 350 lines of that is filesystem boilerplate.
There's also maybe 100-200 lines of interfacing with the filesystem,
but they'd probably be there as configfs-interfacing code if it was
over configfs.

Paul
