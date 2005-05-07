Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262704AbVEGFAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbVEGFAW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 01:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbVEGFAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 01:00:21 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:2499 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262704AbVEGFAR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 01:00:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TcBvusllSypBdkAU9WpOnzfW1K9i5a/MpLFKXBnyhcJaPB5566V5WPfZYxNBGVGiksw74g7emF5RBAdhSJOU0tOmkPsOHXzdMADLyGs6ql7dZ5xmc3WUWVeywzZSlI2fpFSpMrcGAN5O6S6RI7YTe7hER/7sP7uTX9jXX5/CQu0=
Message-ID: <7d04ec5605050622006f3ad56c@mail.gmail.com>
Date: Fri, 6 May 2005 22:00:17 -0700
From: rajat swarup <rajats@gmail.com>
Reply-To: rajat swarup <rajats@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: sending ICMP messages in kernel module
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have placed a netfilter hook in which I grab the packets in the
pre-routing stage.
I need to send ICMP messages in response to certain messages in this hook.
I looked at alloc_skb(), skb_reserve() and skb_put() functions but it
is still not clear to me as to how to construct the packets using
these methods.
Since I am getting the packets in the Pre-routing stage should I
explicitly construct the MAC header, IP header & data & ICMP message?
Also, I'll need to calculate the checksum to be transmitted in the
ICMP packet...which method could I use to do that?

Any help will be really appreciated!

Thanks and regards,
Rajat.
http://rajatswarup.blogspot.com/
