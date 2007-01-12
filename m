Return-Path: <linux-kernel-owner+w=401wt.eu-S932294AbXALRck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbXALRck (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 12:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbXALRck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 12:32:40 -0500
Received: from smtp-out.google.com ([216.239.45.13]:20105 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932294AbXALRcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 12:32:39 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=MjAOfz8tnjdp2Bza1PdxbMuPrgFC0nmRP6y1V5sQ5FLx0qcEHSd9S1FhpLKADPmGa
	mLHMvwHFDkPmz1tBEnb3w==
Message-ID: <6599ad830701120932i2560df75o98f08e7da7efda65@mail.gmail.com>
Date: Fri, 12 Jan 2007 09:32:26 -0800
From: "Paul Menage" <menage@google.com>
To: balbir@in.ibm.com
Subject: Re: [ckrm-tech] [PATCH 4/6] containers: Simple CPU accounting container subsystem
Cc: vatsa@in.ibm.com, sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, xemul@sw.ru, dev@sw.ru,
       containers@lists.osdl.org, pj@sgi.com, mbligh@google.com,
       winget@google.com, rohitseth@google.com, serue@us.ibm.com,
       devel@openvz.org
In-Reply-To: <45A74634.4050600@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061222141442.753211763@menage.corp.google.com>
	 <20061222145216.755437205@menage.corp.google.com>
	 <45A4F675.3080503@in.ibm.com>
	 <6599ad830701111633j2ae65807sad393d2dad44a260@mail.gmail.com>
	 <45A729A9.5070902@in.ibm.com>
	 <6599ad830701120015k440a16c8sec25a4db23865ebd@mail.gmail.com>
	 <45A74634.4050600@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/07, Balbir Singh <balbir@in.ibm.com> wrote:
>
> I understand that the features are exported to userspace. But from
> the userspace POV only the mount options change - right?
>

The mount options, plus the fact that you can mount different
instances of containerfs with different resource controller sets to
get different hierarchies. (Multiple mounts with the same controller
sets share the same superblock/hierarchy).

Paul
