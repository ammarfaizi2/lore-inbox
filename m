Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266104AbTFWSwh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 14:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266105AbTFWSwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 14:52:37 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:19446 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S266104AbTFWSvk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 14:51:40 -0400
Subject: Re: [RFC][PATCH] Security hook for vm_enough_memory
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       James Morris <jmorris@intercode.com.au>,
       lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
In-Reply-To: <1056386424.14228.78.camel@dhcp22.swansea.linux.org.uk>
References: <1056385527.1709.415.camel@moss-huskers.epoch.ncsc.mil>
	 <1056386424.14228.78.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1056395094.1709.467.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jun 2003 15:04:55 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-23 at 12:40, Alan Cox wrote:
> Is there any reason for not wrapping the entire vm_enough_memory() function
> and using the current one as default. In some environments being able to make
> total commit constraints based on roles may actually be useful.
> 
> (Think "sum of students memory < 40% of system" 8))
> 
> vm_enough_memory has to be kernel side but its basically policy so pluggable
> IMHO is good.

This sounds useful; I'll rework the patch accordingly and resubmit.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

