Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266288AbUANAV5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 19:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266289AbUANAV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 19:21:56 -0500
Received: from pizda.ninka.net ([216.101.162.242]:10959 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S266288AbUANAVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 19:21:54 -0500
Date: Tue, 13 Jan 2004 16:12:57 -0800
From: "David S. Miller" <davem@redhat.com>
To: James Morris <jmorris@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil,
       selinux@tycho.nsa.gov
Subject: Re: [PATCH][SELINUX] 6/7 Add SO_PEERSEC socket option and
 getpeersec LSM hook.
Message-Id: <20040113161257.40f1ff16.davem@redhat.com>
In-Reply-To: <Xine.LNX.4.44.0401091023430.21309-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0401091021000.21309@thoron.boston.redhat.com>
	<Xine.LNX.4.44.0401091023430.21309-100000@thoron.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jan 2004 10:42:09 -0500 (EST)
James Morris <jmorris@redhat.com> wrote:

> This patch against 2.6.1-mm1 adds a new option for Unix sockets,
> SO_PEERSEC, and an associated LSM hook, getpeersec.  The SELinux handler 
> is also included.
> 
> The purpose of this is to allow applications to obtain each others
> security credentials, analagously to the existing SO_PEERCRED option.  

I'm totally fine with this patch but I cannot apply it as it will not go in
cleanly without your previous SELINUX bits applied, please resend to me
when that stuff goes in.
