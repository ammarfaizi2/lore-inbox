Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161110AbWJKRKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161110AbWJKRKl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 13:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161149AbWJKRKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 13:10:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:30991 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161110AbWJKRKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 13:10:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=Q2ZHCj02w+pfRPNkLGDdtLeaITvvTk4d9pWFQyfO2+ayK4XSWuNDQooJFmjiwtZILVuwN6MKx+vzPrsDWO9muqGbtmD3UfbNQa/5Ju3CVjWocrp+aW7FMDwkBMjK+446zglYnOH1q1KlTkTNYhMRgVIUb94Ls0WcmtY5F6ig0xE=
Message-ID: <e4cb19870610111010p3da2022bud047163417560033@mail.gmail.com>
Date: Wed, 11 Oct 2006 13:10:31 -0400
From: "Thomas Tuttle" <thinkinginbinary+lkml@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Dell Inspiron e1405 hangs on lid close in 64-bit mode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: 15bc773198aafdf6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Dell Inspiron e1405 laptop with a Core 2 Duo processor.
Under every 64-bit kernel I have tried yet, it hangs when I close the
lid (or, I would assume, do anything else that activates System
Management Mode).  It works fine under 32-bit mode; closing the lid
turns the LCD off using DPMS.

I understand that this might be entirely outside the control of the
kernel developers, but I would of course love to be able to use this
laptop in 64-bit mode.  What information would be needed to fix it,
and/or how would I go about debugging it?  I've tried turning the
console loglevel up to 9, but no information is printed right before
the crash (probably since an exception occurs in SMM, and isn't
caught?).  I think booting with noacpi (I'm not sure, I'll check) made
it work, but disabled all the power management features, making the
rest of the laptop much less useful.

Thanks in advance,

Thomas Tuttle
