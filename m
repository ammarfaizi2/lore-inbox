Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbWHOAwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbWHOAwj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 20:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbWHOAwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 20:52:39 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:11327 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965041AbWHOAwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 20:52:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=gKvJQN/vPAXAoaweV2NAIDMgjX7SSaM2jC1hmm4lkhG9E5rV6+zkTXtDOyAhKTeXBaS3JaPrcjoTlC0tz4aQCuxb7MxqYDDWyrJtKbqzdmtmCbQ+su7ciYUlUwvKloZbhiFqUbeIhf0L3lXKQPw9B8bFoPG5ckYeCFae57Xpuys=
Subject: Oops on suspend
From: "Antonino A. Daplas" <adaplas@gmail.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 15 Aug 2006 08:52:31 +0800
Message-Id: <1155603152.3948.4.camel@daplas.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone see this oops on suspend to disk? Copied by hand only.

EIP is at swap_type_of

swsusp_write
pm_suspend_disk
enter_state
state_store
subsys_attr_store
sysfs_write_file
vfs_write
sys_write
sysenter_past_EIP

openSUSE-10.2-Alpha3 (2.6.18-rc4), but I see this also with stock
2.6.18-rc4-mm1.

Tony

