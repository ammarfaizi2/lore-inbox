Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbTICJfh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 05:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbTICJfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 05:35:37 -0400
Received: from ns1.mvps.org ([158.64.60.224]:18025 "EHLO
	edge.zoo.securewave.com") by vger.kernel.org with ESMTP
	id S261698AbTICJfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 05:35:33 -0400
Subject: mmap(MAP_PRIVATE) question
From: Gianni Tedesco <giannit@securewave.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1062581651.489.5.camel@lemsip>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 03 Sep 2003 11:34:11 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

>From the mmap(2) manpage it says:

MAP_PRIVATE
Create a private copy-on-write mapping.  Stores to the region do not
affect the  original  file.   It  is  unspecified whether changes made
to the file after the mmap call are visible in the mapped region.

What is linux behaivour in this area? I am guessing if the page is
modified between the call to mmap() and fault-in then the modified copy
is seen by the application? But what about modifications after the page
is already in page-cache?

Thanks.

-- 
Gianni Tedesco <giannit@securewave.com>

