Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbVHYPRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbVHYPRD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 11:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVHYPRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 11:17:03 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:60382 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751147AbVHYPRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 11:17:00 -0400
Subject: Re: [PATCH 5/5] Remove unnecesary capability hooks in rootplug.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: serue@us.ibm.com
Cc: Chris Wright <chrisw@osdl.org>, linux-security-module@wirex.com,
       Greg Kroah <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Kurt Garloff <garloff@suse.de>, James Morris <jmorris@redhat.com>
In-Reply-To: <20050825143807.GA8590@sergelap.austin.ibm.com>
References: <20050825012028.720597000@localhost.localdomain>
	 <20050825012150.490797000@localhost.localdomain>
	 <20050825143807.GA8590@sergelap.austin.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 25 Aug 2005 11:13:56 -0400
Message-Id: <1124982836.3873.78.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 09:38 -0500, serue@us.ibm.com wrote:
> Ok, with the attached patch SELinux seems to work correctly.  You'll
> probably want to make it a little prettier  :)  Note I have NOT ran the
> ltp tests for correctness.  I'll do some performance runs, though
> unfortunately can't do so on ppc right now.

Note that the selinux tests there _only_ test the SELinux checking.  So
if these changes interfere with proper stacking of SELinux with
capabilities, that won't show up there.  

-- 
Stephen Smalley
National Security Agency

