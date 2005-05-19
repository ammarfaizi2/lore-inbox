Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262502AbVESN7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbVESN7L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 09:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbVESN7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 09:59:11 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:5536 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262502AbVESN7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 09:59:02 -0400
Subject: Re: why nfs server delay 10ms in nfsd_write()?
From: Lee Revell <rlrevell@joe-job.com>
To: Peter Staubach <staubach@redhat.com>
Cc: steve <lingxiang@huawei.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "zhangtiger@huawei.com" <zhangtiger@huawei.com>
In-Reply-To: <428C8C32.2030803@redhat.com>
References: <0IGP00IZRULADZ@szxml02-in.huawei.com>
	 <1116472423.11327.1.camel@mindpipe>  <428C8C32.2030803@redhat.com>
Content-Type: text/plain
Date: Thu, 19 May 2005 09:59:00 -0400
Message-Id: <1116511140.21587.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 08:53 -0400, Peter Staubach wrote:
> There are certainly many others way to get gathering, without adding an
> artificial delay.  There are already delay slots built into the code 
> which could
> be used to trigger the gathering, so with a little bit different 
> architecture, the
> performance increases could be achieved.
> 
> Some implementations actually do write gathering with NFSv3, even.  Is
> this interesting enough to play with?  I suspect that just doing the 
> work for
> NFSv2 is not...

Also, how do you explain the big performance hit that steve observed?
Write gathering is supposed to help performance, but it's a big loss on
his test...

Lee

