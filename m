Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932620AbWFLWVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbWFLWVp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 18:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbWFLWVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 18:21:44 -0400
Received: from wx-out-0102.google.com ([66.249.82.198]:48959 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932620AbWFLWVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 18:21:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ModTwPqIwcL17b6sLy3VyWcCTr/GMPANZxbext6PjreAQgQIpFhzvdurUOqpATpHiEo1Zmidf+gBOQvCppQePkdkMc8girR4nJB4es8l1ZC1noTtR4EP/bUE7b569VzqIU/cWM9MAMQo5atB7BGGPu++FFhHnMaERF0E4PG1qAk=
Message-ID: <5c49b0ed0606121521r3e938ad2sc547bec1a40b6491@mail.gmail.com>
Date: Mon, 12 Jun 2006 15:21:43 -0700
From: "Nate Diller" <nate.diller@gmail.com>
To: "Vishal Patil" <vishpat@gmail.com>
Subject: Re: CSCAN vs CFQ I/O scheduler benchmark results
Cc: "Jens Axboe" <axboe@suse.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Jan Engelhardt" <jengelh@linux01.gwdg.de>
In-Reply-To: <4745278c0606121038y7fcdab2q33a9065e9071938b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4745278c0606091230g1cff8514vc6ad154acb62e341@mail.gmail.com>
	 <4745278c0606091915n3ed7563do505664c4f8070f81@mail.gmail.com>
	 <20060611185854.GF13556@suse.de>
	 <4745278c0606111647g7ca1392bjb46936f69d6b668d@mail.gmail.com>
	 <20060612064136.GB4420@suse.de>
	 <4745278c0606121038y7fcdab2q33a9065e9071938b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/06, Vishal Patil <vishpat@gmail.com> wrote:
> Jens
>
> Could you let me know what tests would be fair to make comparsion
> between the I/O schedulers? Thanks.

any filesystem benchmark should be informative, namesys tests with a
whole suite, bonnie++, iozone, mongo (custom), and one or two others.
You can ask on reiserfs-list for more information.

I suggest testing against more than one filesystem as well, it's quite
common for a FS to "prefer" one scheduler.

NATE
