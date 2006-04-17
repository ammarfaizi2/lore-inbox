Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWDQTbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWDQTbM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 15:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWDQTbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 15:31:12 -0400
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:33511 "EHLO
	mail2.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751234AbWDQTbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 15:31:11 -0400
Date: Mon, 17 Apr 2006 15:31:08 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: "Serge E. Hallyn" <serue@us.ibm.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
In-Reply-To: <20060417192634.GB18990@sergelap.austin.ibm.com>
Message-ID: <Pine.LNX.4.64.0604171528340.17923@d.namei>
References: <20060417180231.71328.qmail@web36606.mail.mud.yahoo.com>
 <1145297742.8542.206.camel@moss-spartans.epoch.ncsc.mil>
 <20060417192634.GB18990@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2006, Serge E. Hallyn wrote:

> Hopefully a new version of evm+slim+ima will be ready for distribution
> soon.

Why are you still trying to introduce yet another access control model 
into the kernel, when SELinux is already there?

Last I recall on this issue, we asked if you could look at providing 
integrity measurement as a distinct API, and integrity control as either 
integrated with SELinux or a distinct component which SELinux could use.



- James
-- 
James Morris
<jmorris@namei.org>
