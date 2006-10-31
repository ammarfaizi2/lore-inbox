Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423595AbWJaQyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423595AbWJaQyr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423596AbWJaQyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:54:46 -0500
Received: from smtp-out.google.com ([216.239.45.12]:7501 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1423595AbWJaQyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:54:45 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=RoMrHe1+VDSHslNrVlN+uBYoNRl1RDNcByFdZm0UAJCtUooLgI5ZP7e9hkX1YThZA
	nUT00i5VS9wMBbTl3/6Jg==
Message-ID: <6599ad830610310854ke6bac53sf1be893efc0d5942@mail.gmail.com>
Date: Tue, 31 Oct 2006 08:54:34 -0800
From: "Paul Menage" <menage@google.com>
To: "Pavel Emelianov" <xemul@openvz.org>
Subject: Re: [ckrm-tech] RFC: Memory Controller
Cc: balbir@in.ibm.com, vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com, linux-mm@kvack.org
In-Reply-To: <4547305A.9070903@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030103356.GA16833@in.ibm.com> <4545D51A.1060808@in.ibm.com>
	 <4546212B.4010603@openvz.org> <454638D2.7050306@in.ibm.com>
	 <45470DF4.70405@openvz.org> <45472B68.1050506@in.ibm.com>
	 <4547305A.9070903@openvz.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/06, Pavel Emelianov <xemul@openvz.org> wrote:
>
> Paul Menage won't agree. He believes that interface must come first.

No, I'm just trying to get agreement on the generic infrastructure for
process containers and extensibility - the actual API to the memory
controller (i.e. what limits, what to track, etc) can presumably be
fitted into  the generic mechanism fairly easily (or else the
infrastructure probably isn't generic enough).

Paul
