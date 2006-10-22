Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWJVQ23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWJVQ23 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 12:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWJVQ23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 12:28:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:38435 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751132AbWJVQ22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 12:28:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mRudfZTufeEKXsAftAiJ2ghaAwQi4RvqfZapn9Qtux9hg4EA24uWXA6VfsO1JHYYKrgtis7vkcZAreE5JOORfhX/F4Tw5GNK+FbF+KDo2zqb05XpWiWdosRyiE6vFKQ0ZIqlXDBN203nWW0zMLOkBMzpe2mRT3iIPCvzNPTFXBc=
Message-ID: <86802c440610220928vbbe1023t25be1df0943eb471@mail.gmail.com>
Date: Sun, 22 Oct 2006 09:28:26 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: "Muli Ben-Yehuda" <muli@il.ibm.com>
Subject: Re: [PATCH] x86-64: typo in __assign_irq_vector when updating pos for vector and offset
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andi Kleen" <ak@suse.de>
In-Reply-To: <20061022162013.GE4354@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200610212100.k9LL0GtC018787@hera.kernel.org>
	 <20061022035109.GM5211@rhun.haifa.ibm.com>
	 <86802c440610220128v2e103912sbfba193484fb6304@mail.gmail.com>
	 <20061022085036.GP5211@rhun.haifa.ibm.com>
	 <86802c440610220902q648a7fc8p38fd9a3391f5bc5d@mail.gmail.com>
	 <20061022162013.GE4354@rhun.haifa.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/06, Muli Ben-Yehuda <muli@il.ibm.com> wrote:
> All of the tests I ran were with NR_CPUS=8. Shall I try NR_CPUS=4?

So per_cpu only can be used onlined cpus?

I wonder if you try NR_CPUS without the patch, you will get more strange result.

YH
