Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWH0QAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWH0QAP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 12:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWH0QAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 12:00:15 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:52920 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932147AbWH0QAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 12:00:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SeD2rF3dI5uxr+neyOoYH9nFK4+pDmWnN1nGS1wNLcWK/f8p9LS+rUSRwj2SeG/YKqfiyvoqs+oTATbl/e9PJFHbHdsZlWTE7f1W9NmWDKaDpES/Tp27feCHwzAlFRiX2tNNe4JroFg6Cq/4dqZfAEDS2gujNklb/dwWVf7XBgc=
Message-ID: <40f323d00608270900v88a78abh6e9f37b51d164909@mail.gmail.com>
Date: Sun, 27 Aug 2006 18:00:12 +0200
From: "Benoit Boissinot" <bboissin@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.18-rc4-mm3
Cc: linux-kernel@vger.kernel.org,
       "Venkatesh Pallipadi" <venkatesh.pallipadi@intel.com>,
       "Len Brown" <len.brown@intel.com>
In-Reply-To: <20060826160922.3324a707.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060826160922.3324a707.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm3/
>
>  git-acpi.patch

commit f62d31ee2f2f453b07107465fea54540cab418eb broke my laptop
(pentium M, dell D600).
I can reliably get a hard lockup (no sysrq) when modprobing ehci_hcd
and uhci_hci. It works when reverting the changeset.

I can provide cpuinfo or dmesg if necessary.

regards,

Benoit
