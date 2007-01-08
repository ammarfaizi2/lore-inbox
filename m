Return-Path: <linux-kernel-owner+w=401wt.eu-S1751459AbXAHGru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbXAHGru (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 01:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbXAHGrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 01:47:49 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:45420 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbXAHGrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 01:47:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JyuLF0zED/lhshra2iuL3WCiB0M5glBmJcvcwkcwRIXsNk8Pn8iqAncAElPvwZ0zsFeyONYJP6X3rMwBqqprGiv079SzilXQEzUJnHWvoH5W3eKzpbc4AuAZj10TaPfM4Y+7Uh4ycAMMTv0GJJ1poprrl/QoMtEzokd09SR4cPM=
Message-ID: <eada2a070701072247w165f9beem6d24ec8e3325c6f3@mail.gmail.com>
Date: Sun, 7 Jan 2007 22:47:47 -0800
From: "Tim Pepper" <tpepper@gmail.com>
To: "Dave Hansen" <haveblue@us.ibm.com>
Subject: Re: [PATCH] Fix sparsemem on Cell (take 3)
Cc: "John Rose" <johnrose@austin.ibm.com>, "Andrew Morton" <akpm@osdl.org>,
       "External List" <linuxppc-dev@ozlabs.org>,
       "KAMEZAWA Hiroyuki" <kamezawa.hiroyu@jp.fujitsu.com>,
       kmannth@us.ibm.com, lkml <linux-kernel@vger.kernel.org>,
       hch@infradead.org, linux-mm@kvack.org,
       "Paul Mackerras" <paulus@samba.org>, mkravetz@us.ibm.com,
       gone@us.ibm.com, "Arnd Bergmann" <arnd@arndb.de>
In-Reply-To: <1168160307.6740.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061215165335.61D9F775@localhost.localdomain>
	 <200612182354.47685.arnd@arndb.de>
	 <1166483780.8648.26.camel@localhost.localdomain>
	 <200612190959.47344.arnd@arndb.de>
	 <1168045803.8945.14.camel@localhost.localdomain>
	 <1168059162.23226.1.camel@sinatra.austin.ibm.com>
	 <1168160307.6740.9.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/07, Dave Hansen <haveblue@us.ibm.com> wrote:
> On Fri, 2007-01-05 at 22:52 -0600, John Rose wrote:
> > Could this break ia64, given that it uses memmap_init_zone()?
>
> You are right, I think it does.

Boot tested OK on ia64 with this latest version of the patch.

(forgot to click plain text on gmail the first time..sorry if you got
html mail or repeat)


Tim
