Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbVLNSRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbVLNSRE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 13:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbVLNSRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 13:17:03 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:41895 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964862AbVLNSRB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 13:17:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bZ7Qh7dOqdc5fEmwNnUKqyFmpHmK6YNnVBSzq1ogx4MqBZKugpoSiNKHzTzpFfJxzqj/9sUd6vchyrvVh5S967OIseIQI0ScQbmuSxq3NoXK/gkOkZMe3WwZKHi6bRwR9WP8TMemA7qKfd2EIhIdmWA2vap6iiC5d2p31oWfoTY=
Message-ID: <8746466a0512141017j141d61dft3dd2b1ab95dc2351@mail.gmail.com>
Date: Wed, 14 Dec 2005 11:17:00 -0700
From: Dave <dave.jiang@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: x86_64 segfault error codes
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For segfault error codes on x86_64, bits 0-3 are documented in
arch/x86_64/mm/fault.c. However, I am getting error 0x14 and 0x15 with this
particular user app when it segfaults. Is bit 4 valid and what does that
imply?

xxx-001[2085]: segfault at 0000007f960ea86b rip 0000007f960ea86b rsp
0000007fbfffe968 error 14
xxx-001[2091]: segfault at 0000007fbfffe670 rip 0000007fbfffe670 rsp
0000007fbfffe668 error 15

--
-= Dave =-
