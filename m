Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752261AbWKGTZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbWKGTZJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 14:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752254AbWKGTZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 14:25:09 -0500
Received: from smtp-out.google.com ([216.239.45.12]:28402 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1752190AbWKGTZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 14:25:07 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=xMahOTxaNGS170z5exvxlQUp4kCI52BGIqfkTPCaCPWmCqIuHm8kaxuhb66IKNMRA
	46hmnRCSbK0/YXDdsPi/A==
Message-ID: <6599ad830611071124p7e0d5b20r67bbc8f8d75b3f44@mail.gmail.com>
Date: Tue, 7 Nov 2006 11:24:49 -0800
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Cc: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
In-Reply-To: <20061107111131.48a9ae49.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030031531.8c671815.pj@sgi.com>
	 <20061031115342.GB9588@in.ibm.com>
	 <6599ad830610310846m5d718d22p5e1b569d4ef4e63@mail.gmail.com>
	 <20061101172540.GA8904@in.ibm.com>
	 <6599ad830611011537i2de812fck99822d3dd1314992@mail.gmail.com>
	 <20061106124948.GA3027@in.ibm.com>
	 <6599ad830611061223m77c0ef1ei72bd7729d9284ec6@mail.gmail.com>
	 <20061107104118.f02a1114.pj@sgi.com>
	 <6599ad830611071107u4226ec17h5facc7ee2ad53174@mail.gmail.com>
	 <20061107111131.48a9ae49.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/06, Paul Jackson <pj@sgi.com> wrote:
> > This will happen if you configure CONFIG_CPUSETS_LEGACY_API
>
> So why is this CONFIG_* option separate?  When would I ever not
> want it?

If you weren't bothered about having the legacy semantics. The main
issue is that it adds an extra file to /proc/<pid>. I guess the other
stuff could be made nonconditional without breaking anyone who didn't
try to mount cpusetfs

Paul
