Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWIXNrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWIXNrn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 09:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWIXNrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 09:47:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:4846 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750860AbWIXNrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 09:47:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MGdA/Bn8ZIhP9WK+iXDS4MSvL3jZ1QBFUknl7mtZK0oSJx/Ra7PyYNn1v6GhpjnMOxC8P0FFocItTduyq5WzK0YxAg29QedGSzDTnrz8bd/rLKSRceQ5+kZS1G8Zkq5l8umnr6cDkC/N75ij9uWgfAX7zu5dqOmNvA+bG+GQq4k=
Message-ID: <b6fcc0a0609240647v2df20521m9ee4f4af9785a23c@mail.gmail.com>
Date: Sun, 24 Sep 2006 17:47:41 +0400
From: "Alexey Dobriyan" <adobriyan@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: unsigned long flags; (was Re: 2.6.18-mm1)
Cc: linux-kernel@vger.kernel.org, "Haavard Skinnemoen" <hskinnemoen@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

avr32 does unsigned int flags in show_dtlb_entry() and tlb_show()
