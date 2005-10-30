Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbVJ3KpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbVJ3KpF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 05:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbVJ3KpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 05:45:04 -0500
Received: from cassarossa.samfundet.no ([129.241.93.19]:65183 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S1751283AbVJ3KpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 05:45:02 -0500
Date: Sun, 30 Oct 2005 11:45:27 +0100
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org
Subject: Re: BIND hangs with 2.6.14
Message-ID: <20051030104527.GB32446@uio.no>
References: <20051030023557.GA7798@uio.no> <20051030101148.GA18854@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20051030101148.GA18854@outpost.ds9a.nl>
X-Operating-System: Linux 2.6.14-rc5 on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 11:11:48AM +0100, bert hubert wrote:
>> We upgraded one of our servers (single Opteron, running 64-bit kernel but
>> 32-bit userland) from 2.6.11.9 to 2.6.14 (with the additional NFS patches,
>> but that shouldn't really matter) today, and now BIND seems to hang every few
>> hours. (Everything on the machine except for the kernel is Debian sarge, so
>> we're using BIND 9.2.4 and glibc 2.3.2, with NPTL.) I'm unsure what's really
>> happening, but it doesn't respond to any requests at all, a plain strace on
>> the process gives nothing, ltrace gives nothing, and it doesn't use any CPU.
> Is BIND touching anything on NFS?

No, it isn't.

/* Steinar */
-- 
Homepage: http://www.sesse.net/
