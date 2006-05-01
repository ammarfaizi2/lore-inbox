Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWEAV7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWEAV7y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWEAV7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:59:53 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:2481 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932292AbWEAV7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:59:52 -0400
Subject: Re: [PATCH 7/7] uts namespaces: Implement CLONE_NEWUTS flag
From: Dave Hansen <haveblue@us.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: ebiederm@xmission.com, herbert@13thfloor.at, dev@sw.ru,
       linux-kernel@vger.kernel.org, sam@vilain.net, xemul@sw.ru,
       clg@us.ibm.com, frankeh@us.ibm.com
In-Reply-To: <20060501211109.GA21799@sergelap.austin.ibm.com>
References: <20060501203906.XF1836@sergelap.austin.ibm.com>
	 <20060501203907.XF1836@sergelap.austin.ibm.com>
	 <1146515316.32079.27.camel@localhost.localdomain>
	 <20060501211109.GA21799@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Mon, 01 May 2006 14:58:52 -0700
Message-Id: <1146520732.32079.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-01 at 16:11 -0500, Serge E. Hallyn wrote:
> Might be worth a separate patch to change over all those helpers in
> fork.c?  (I think they were all brought in along with the sys_unshare
> syscall)

I'd be a little scared to touch good, working code, but it couldn't hurt
to see the patch.

-- Dave

