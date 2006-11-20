Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934016AbWKTIxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934016AbWKTIxM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 03:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934019AbWKTIxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 03:53:12 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:1458 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S934016AbWKTIxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 03:53:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZuieoeqHYjg8zZuzwGIfK35TUjFcYseHNfWq4RLiwTOm7WwCMGqdIpQhguN+nJlMdmXKgDAsPM64rwqPGMzNBOHk4lLGzYB8CwY/CyCgvmUCiPLuMrrM0wr58jPQzIPZLCeQ226RqFf5vYI0n1ry2/tqKIJVmMizHddFrqv4EXE=
Message-ID: <dfed62190611200053g3fff5296te8251a22675730e0@mail.gmail.com>
Date: Mon, 20 Nov 2006 10:53:09 +0200
From: "Samuel Korpi" <strontianite@gmail.com>
To: "Thushara Wijeratna" <thushw@gmail.com>
Subject: Re: some help in kernel debugging
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2625b9520611171304x213b3bc6h6e2a40d43ce4497c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2625b9520611171304x213b3bc6h6e2a40d43ce4497c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't know what sort of debugging needs you have, exactly, but I
would suggest you take a look at User Mode Linux (UML). UML provides a
safe and pretty easy way to start you with kernel debugging and just
looking into kernel internals. It is a virtual kernel running in user
space, so it doesn't require a separate test machine, and you can
debug it with normal gdb. Furthermore, it is included in current
vanilla kernels, so you can get started without any extra patches.

Main sources for information concerning UML are:

Main page: http://www.user-mode-linux.org/
HOWTO: http://user-mode-linux.sourceforge.net/UserModeLinux-HOWTO.html
Wiki: http://uml.jfdi.org/
Precompiled kernels and root file systems: http://uml.nagafix.co.uk/

/Samuel Korpi
