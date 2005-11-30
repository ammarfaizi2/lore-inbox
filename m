Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbVK3MEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbVK3MEs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 07:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVK3MEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 07:04:48 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:32878 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751172AbVK3MEs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 07:04:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KMDWW6WEpjGc/6cUAS4Twe0idp/yWEfFlXe7jzv6S92yYuDTeOTEaZug2scbg6ZTLA0OQVz+FNOnRt2kSU9489BD59CGezcR+mtDTjmGqfh6yG06tAihORcVI/MQTvXNDwkD/6NBp3WBxi8x8DlgPMs4Sh5Q6kQMkIqPwCJypWo=
Message-ID: <6278d2220511300404i27878f02mf5d8c948256d36e8@mail.gmail.com>
Date: Wed, 30 Nov 2005 12:04:46 +0000
From: Daniel J Blueman <daniel.blueman@gmail.com>
To: jgarzik@pobox.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PAT status?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

IIRC, the kernel (c. 2.6.14) still does nothing to setup the
processors' PAT registers to enable write combining in one of the
slots - the defaults the BIOS establishes do not cover this. Once this
is done, drivers would readily be able to set page flags for a
particular PAT slot, and MTRRs can (almost) be safely ignored.

Daniel
___
Daniel J Blueman
