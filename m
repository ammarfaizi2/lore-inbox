Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbVLDVhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbVLDVhR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 16:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVLDVhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 16:37:17 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:37514 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932330AbVLDVhP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 16:37:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mjEs+c3GqvYadQQux2jtsBuSZrhOvRxvLXGV+9YCyYgSsssKEnzP8baQnB/cjoM5R28i9UKbYCf40o8TeY2EVNxuJsW5DXEIhp8WWOies0Cde97d7HncqJNQUWzpIf2GQRgHe24T9p71DNjwY0YMzxFUUf0WGGM8gX0h4sjHsE4=
Message-ID: <afd776760512041337l40a1879drb8b0b526100791a8@mail.gmail.com>
Date: Sun, 4 Dec 2005 15:37:13 -0600
From: Mohamed El Dawy <msdawy@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Is the address space of a process continous
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I have a question. In the vma_memory_address struct, there are 2
fields "vm_start" and "vm_end". I was wondering, does the process
address space include all addresses between those 2 addresses? or
could there be holes inside this range?

The main reason I am asking is because I tried to call __follow_page()
on some of those addresses and got NULL as a result. I am not sure if
this is a hole, or just a problem with my code!

Thanks a lot in advance
