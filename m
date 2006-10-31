Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423591AbWJaQxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423591AbWJaQxe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423590AbWJaQxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:53:34 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:57236 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1423591AbWJaQxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:53:33 -0500
Date: Tue, 31 Oct 2006 22:27:48 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: "Paul Menage" <menage@google.com>
Cc: "Pavel Emelianov" <xemul@openvz.org>, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com, devel@openvz.org
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-ID: <20061031165748.GA15236@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061030103356.GA16833@in.ibm.com> <45460743.8000501@openvz.org> <6599ad830610301001i2ad35290u63839e920d82a5f4@mail.gmail.com> <454709E0.1000409@openvz.org> <6599ad830610310834g12a66aan29b568d7f9a5525@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6599ad830610310834g12a66aan29b568d7f9a5525@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 08:34:52AM -0800, Paul Menage wrote:
> How about the cpusets approach, where once a cpuset has no children
> and no processes, a usermode helper can be executed - this could
> immediately remove the container/bean-counter if that's what the user
> wants. My generic containers patch copies this from cpusets.

Bingo. We crossed mails!

Kirill/Pavel,
	As I mentioned in the begining of this thread, one of the
objective of this RFC is to seek consensus on what could be a good
compromise for the infrastructure in going forward. Paul Menage's
patches, being rework of existing code, is attactive to maintainers like
Andew. 

>From that perspective, how well do you think the container
infrastructure patches meet your needs?

-- 
Regards,
vatsa
