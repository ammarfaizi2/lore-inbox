Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWJ3MFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWJ3MFH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 07:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWJ3MFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 07:05:07 -0500
Received: from smtp-out.google.com ([216.239.33.17]:34042 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750820AbWJ3MFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 07:05:04 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=FXTmw/a9cqoWHXnPVMoS+WBz3SMyGuc84qJNJ99fEvgaP5aODGGAWUmONp5ep28Ta
	UGjlPgkw26vqdEks9MVqA==
Message-ID: <6599ad830610300404v1e036bb7o7ed9ec0bc341864e@mail.gmail.com>
Date: Mon, 30 Oct 2006 04:04:46 -0800
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Cc: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
In-Reply-To: <20061030031531.8c671815.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030103356.GA16833@in.ibm.com>
	 <6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com>
	 <20061030031531.8c671815.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/06, Paul Jackson <pj@sgi.com> wrote:
> It would be nice, me thinks, if the underlying container technology
> didn't really care whether we had one hierarchy or seven.  Let the
> users (such as CKRM/RG, cpusets, ...)

I was thinking that it would be even better if the actual (human)
users could determine this; have the container infrastructure make it
practical to have flexible hierarchy mappings, and have the resource
controller subsystems not have to care about how they were being used.

Paul
