Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262131AbVAJHad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbVAJHad (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 02:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbVAJHad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 02:30:33 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:42795 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262131AbVAJHaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 02:30:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=WDCl+4EEoC9hphTXKLktKkvq4QDvvtJwxMtdsUe0MUN2KE6+zbkj3BePIitG6/zbxeEekY8ml8JYUw53VBOTyfIlAatZldXsaq7lfPsYRB+7GBqYz6aTOVlB/S8pjnl9Ss0pf/CYRW5y9PMuBVOqAk7vPNToEmTThlUIMqxUfwQ=
Message-ID: <9dc88b850501092330328ae5cb@mail.gmail.com>
Date: Mon, 10 Jan 2005 15:30:17 +0800
From: muzi li <muzili@gmail.com>
Reply-To: muzi li <muzili@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: file system crashed when using samba?
In-Reply-To: <267988DEACEC5A4D86D5FCD780313FBB03500DB7@exch-03.noida.hcltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <267988DEACEC5A4D86D5FCD780313FBB03500DB7@exch-03.noida.hcltech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys:
      I have two boxes, one is gentoo, the othe is win2k. The gentoo
use gentoo kernel 2.6.10-r2.The file systems crashed last nigth, and
my gentoo box can't power on then.The step below:
      1. I mount the win2k share disk to my gentoo box.
      2. I copy 100MB file from my win2k to my gentoo box, then the
win2k box power off.
      3. I check the gentoo box log , found some smb sync errors,
      4. Then my gentoo box doesn't work, I can't exeute  any bin file
and can't change to any directory, I guess the file systems
crashed.Then I reset the box for pressing the reset button, but the
system stopped at "Mounting proc system at /proc" in /sbin/rc.

Now how can I do? Is this a kernel bug or samba bug?
