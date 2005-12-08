Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbVLHEun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbVLHEun (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 23:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbVLHEun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 23:50:43 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:46097 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1751177AbVLHEun
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 23:50:43 -0500
Date: Thu, 8 Dec 2005 00:42:36 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "SERGE E. HALLYN [imap]" <serue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hubertus Franke <frankeh@watson.ibm.com>, Paul Jackson <pj@sgi.com>
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-ID: <20051208054236.GA14181@ccure.user-mode-linux.org>
References: <20051114212341.724084000@sergelap> <m1slt5c6d8.fsf@ebiederm.dsl.xmission.com> <1133977623.24344.31.camel@localhost> <m1hd9kd89y.fsf@ebiederm.dsl.xmission.com> <1133991650.30387.17.camel@localhost> <m18xuwd015.fsf@ebiederm.dsl.xmission.com> <1133994685.30387.47.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133994685.30387.47.camel@localhost>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 02:31:25PM -0800, Dave Hansen wrote:
> I don think any of Solaris containers, ppc64 LPARs, Xen, UML, or
> vservers can recurse.  

UML can, but it's not a heavily exercised option, and it needs some fixes in
order to recurse in the currently favored mode of operation.

				Jeff
