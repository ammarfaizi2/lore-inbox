Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbVCPA4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbVCPA4V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 19:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbVCPA4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 19:56:21 -0500
Received: from hacksaw.org ([66.92.70.107]:30655 "EHLO hacksaw.org")
	by vger.kernel.org with ESMTP id S262171AbVCPA4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 19:56:16 -0500
Message-Id: <200503160056.j2G0u0hu003278@hacksaw.org>
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.0.4
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, chrisw@osdl.org, torvalds@osdl.org,
       akpm@osdl.org
Subject: Re: Linux 2.6.11.4 
In-reply-to: Your message of "Tue, 15 Mar 2005 16:23:25 PST."
             <20050316002325.GA30645@kroah.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 15 Mar 2005 19:56:00 -0500
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

+	while (dlen >= 2 && dlen >= data[1] && data[1] >= 2) {

Not that it matters much to me, since I don't have to maintain it, but 
couldn't this be:

	while (data[1] >= 2 && dlen >= data[1]) {

I think this captures the relationship and priority.
-- 
http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD


