Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751975AbWJ3SUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbWJ3SUo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 13:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751973AbWJ3SUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 13:20:43 -0500
Received: from smtp-out.google.com ([216.239.33.17]:48683 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751972AbWJ3SUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 13:20:41 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=vz4dhKonqWsJQZi96YjRqI/hTiD3RFyeRPV3U1/yvaS88gsMozxSCp6Ou2VmQP90q
	0GYT+IVdS3toS/rcsHrTw==
Message-ID: <6599ad830610301020y3bc515dbse4f278aad8b03e33@mail.gmail.com>
Date: Mon, 30 Oct 2006 10:20:27 -0800
From: "Paul Menage" <menage@google.com>
To: "Pavel Emelianov" <xemul@openvz.org>
Subject: Re: [ckrm-tech] RFC: Memory Controller
Cc: balbir@in.ibm.com, vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com
In-Reply-To: <4546212B.4010603@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030103356.GA16833@in.ibm.com> <4545D51A.1060808@in.ibm.com>
	 <4546212B.4010603@openvz.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/06, Pavel Emelianov <xemul@openvz.org> wrote:
> and go on discussing the next question - interface.
>
> Right now this is the most diffucult one and there are two
> candidates - syscalls and configfs. I've pointed my objections
> agains configfs and haven't seen any against system calls...
>

Some objections:

- they require touching every architecture to add the new system calls
- they're harder to debug from userspace, since you can't using useful
tools such as echo and cat
- changing the interface is harder since it's (presumably) a binary API

Paul
