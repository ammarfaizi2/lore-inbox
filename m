Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262390AbUKKVaC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbUKKVaC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 16:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbUKKV3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 16:29:10 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:37850 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262386AbUKKV2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 16:28:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=Ud9gaCV2/aPqVebKe/Au+qijQLqeCN432m6GIUxKfippTvFhttgH2yF1RSk98A90BKgNMco1f9MKgBudb3pvcPDOYKAPD/E2Aas9eEsMiOut3s2rhwotNIu7D8pdpC4ll3qyyLbOJ1W3UJci0t5ZBtd3vYHlfP2cv3NXgAmB750=
Message-ID: <8874763604111113281b1cf9a5@mail.gmail.com>
Date: Thu, 11 Nov 2004 16:28:35 -0500
From: Anthony Samsung <anthony.samsung@gmail.com>
Reply-To: Anthony Samsung <anthony.samsung@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: network interface to driver and pci slot mapping
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Given an interface name (like eth0), how do I determine:
The name of the driver (module) for this interface.
The PCI address for this interface, if relevant.

?

I need something that works non-destructively on a live system, that
isn't broken by nameif, and has a strong chance of producing a correct
result. In particular, parsing syslog is out. There's no consistency
in the format of messages and there's no guarantee the logs from
bootup will still be around. And the interface may have been renamed
since then.
