Return-Path: <linux-kernel-owner+w=401wt.eu-S1751021AbWLOBV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWLOBV6 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 20:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWLOBV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 20:21:58 -0500
Received: from wr-out-0506.google.com ([64.233.184.236]:21597 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbWLOBV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 20:21:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=LzyqnfGtKFptaj0OezOK0n9QN5KBFt0Lb43jFxqzG6ul1cjzeZ9/QG65bd/W1VnGVDfszhRgibpvugXeJze09s2jM3tE+cZOm1wg6vGxqHiJQW9EjPDz6gVGG2b81mBdtXktPiaAvylBwI6zqv/WL/jCHJM4HgHlAblnl42i8+g=
Message-ID: <eb97335b0612141721q1696857aw655dfb979670055c@mail.gmail.com>
Date: Thu, 14 Dec 2006 17:21:56 -0800
From: "Zack Weinberg" <zackw@panix.com>
To: "Randy Dunlap" <randy.dunlap@oracle.com>
Subject: Re: [patch 1/4] Add <linux/klog.h>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, jmorris@namei.org,
       "Chris Wright" <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20061214165908.4dc93496.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061215001639.988521000@panix.com>
	 <20061215002333.920560000@panix.com>
	 <20061214165908.4dc93496.randy.dunlap@oracle.com>
X-Google-Sender-Auth: ccb973d7c9f88f59
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/06, Randy Dunlap <randy.dunlap@oracle.com> wrote:
> > -     (void) do_syslog(0,NULL,0);
> > +     (void) do_syslog(KLOG_CLOSE,NULL,0);
>
> Please use a space after the commas (even though you just left it
> as it already was).

Will change for the next revision.

zw
