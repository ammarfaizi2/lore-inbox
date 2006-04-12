Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWDLMdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWDLMdR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 08:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWDLMdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 08:33:17 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:48091 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S932170AbWDLMdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 08:33:17 -0400
Subject: Re: [patch 1/1] selinux: Fix MLS compatibility off-by-one bug
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jmorris@namei.org, rmy@tigress.co.uk
In-Reply-To: <20060411150737.3baf664a.akpm@osdl.org>
References: <1144774386.20422.60.camel@moss-spartans.epoch.ncsc.mil>
	 <20060411150737.3baf664a.akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 12 Apr 2006 08:37:24 -0400
Message-Id: <1144845444.20422.78.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-11 at 15:07 -0700, Andrew Morton wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >
> > This patch fixes an off-by-one error in the MLS compatibility code
> > that was causing contexts with a MLS suffix to be rejected, preventing
> > sharing partitions between FC4 and FC5.  Bug reported in  
> > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=188068
> > Please apply, for 2.6.17 if possible.
> 
> Is this appropriate to 2.6.16.x?

Yes, it seems to meet the criteria.
   
-- 
Stephen Smalley
National Security Agency

