Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266578AbUAWPRM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 10:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266579AbUAWPRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 10:17:12 -0500
Received: from mail.aei.ca ([206.123.6.14]:23247 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S266578AbUAWPRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 10:17:08 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: Evaldo Gardenali <evaldo@gardenali.biz>
Subject: Re: buggy raid checksumming selection?
Date: Fri, 23 Jan 2004 10:16:45 -0500
User-Agent: KMail/1.5.93
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
References: <40112465.8040801@gardenali.biz> <20040123141352.GA19002@redhat.com>
In-Reply-To: <20040123141352.GA19002@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401231016.45225.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 23, 2004 09:13 am, Dave Jones wrote:
> On Fri, Jan 23, 2004 at 11:40:53AM -0200, Evaldo Gardenali wrote:
>  > Uhh. correct me if I am wrong, but shouldnt it select the fastest
>  > algorithm?
>
> No, if it can choose a function which avoids polluting the cache over
> one that doesn't, it will.  Even if that means slightly less raw throughput

In this case it is half the throughput.  When is it reasonable to use the 
fast method?  If never, why even test it?

Ed
