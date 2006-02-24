Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWBXQsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWBXQsr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 11:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWBXQsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 11:48:47 -0500
Received: from ns1.suse.de ([195.135.220.2]:3976 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932221AbWBXQsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 11:48:47 -0500
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
Date: Fri, 24 Feb 2006 17:48:38 +0100
User-Agent: KMail/1.9.1
Cc: Rene Herman <rene.herman@keyaccess.nl>, Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu
References: <1140700758.4672.51.camel@laptopd505.fenrus.org> <43FF26A8.9070600@keyaccess.nl> <m17j7kda52.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m17j7kda52.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602241748.39949.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 February 2006 16:55, Eric W. Biederman wrote:
> there, and... more invasiveness?
> 
> __pa stops working on kernel addresses.

x86-64 always had this problem and it's not very hard to handle with a simple ?:

-Andi
