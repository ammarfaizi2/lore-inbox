Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWALGVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWALGVS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 01:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWALGVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 01:21:18 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29098 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751234AbWALGVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 01:21:17 -0500
To: janak@us.ibm.com
Cc: akpm@osdl.org, viro@ftp.linux.org.uk, dwmw2@infradead.org,
       chrisw@sous-sol.org, jamie@shareable.org, serue@us.ibm.com,
       sds@tycho.nsa.gov, sgrubb@redhat.com, ebiederm@xmission.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 2/10] unshare system call -v5 : system call handler
 function
References: <1137038992.7488.206.camel@hobbes.atlanta.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 11 Jan 2006 23:19:10 -0700
In-Reply-To: <1137038992.7488.206.camel@hobbes.atlanta.ibm.com> (JANAK
 DESAI's message of "Wed, 11 Jan 2006 23:10:46 -0500")
Message-ID: <m1oe2irmsh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JANAK DESAI <janak@us.ibm.com> writes:

> [PATCH -mm 2/10] unshare system call: system call handler function
>
> sys_unshare system call handler function accepts the same flags as
> clone system call, checks constraints on each of the flags and invokes
> corresponding unshare functions to disassociate respective process
> context if it was being shared with another task.

I'm going to log my objection again that you have you are
scrambling the sense of the bits as compare to clone and that
is very confusing.


Eric
