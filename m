Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965121AbVHJOJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbVHJOJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 10:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965120AbVHJOJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 10:09:26 -0400
Received: from mail.enyo.de ([212.9.189.167]:50704 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S965117AbVHJOJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 10:09:26 -0400
From: Florian Weimer <fw@deneb.enyo.de>
To: Janak Desai <janak@us.ibm.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, sds@tycho.nsa.gov,
       linuxram@us.ibm.com, ericvh@gmail.com, dwalsh@redhat.com,
       jmorris@redhat.com, akpm@osdl.org, torvalds@osdl.org, gh@us.ibm.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] New system call, unshare
References: <Pine.WNT.4.63.0508080923470.3668@IBM-AIP3070F3AM>
Date: Wed, 10 Aug 2005 16:08:31 +0200
In-Reply-To: <Pine.WNT.4.63.0508080923470.3668@IBM-AIP3070F3AM> (Janak Desai's
	message of "Mon, 8 Aug 2005 09:28:43 -0400 (Eastern Daylight Time)")
Message-ID: <878xz9dgv4.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Janak Desai:

> With unshare, namespace setup can be done using PAM session
> management functions without patching individual commands.

I don't think it's a good idea to use security-critical code well
without its original specification.  Clearly the current situation
sucks, but this is mainly a lack of PAM functionality, IMHO.
