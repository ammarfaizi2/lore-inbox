Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268706AbUJDXmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268706AbUJDXmO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 19:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268037AbUJDXmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 19:42:14 -0400
Received: from mail.aei.ca ([206.123.6.14]:4345 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S268706AbUJDXmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 19:42:03 -0400
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc3-mm2 ip_conntrack problems
Date: Mon, 4 Oct 2004 19:41:56 -0400
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20041004020207.4f168876.akpm@osdl.org>
In-Reply-To: <20041004020207.4f168876.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410041941.56453.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 October 2004 05:02, Andrew Morton wrote:

> - Hopefully those x86 compile errors are fixed up.
> 
> - Various fairly minor updates
> 
> Changes since 2.6.9-rc3-mm1:

Has anyone figured out how to fix this one (9-rc3-mm1 compiled ok).

  CC [M]  net/ipv4/netfilter/ip_conntrack_standalone.o
net/ipv4/netfilter/ip_conntrack_standalone.c:34:47: linux/netfilter_ipv4/ip_conntrack.h: No such file or directory
In file included from net/ipv4/netfilter/ip_conntrack_standalone.c:35:
include/linux/netfilter_ipv4/ip_conntrack_protocol.h:20: warning: "struct ip_conntrack_tuple" declared inside parameter list

TIA,
Ed
