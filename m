Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbTHYV4N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 17:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbTHYV4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 17:56:13 -0400
Received: from gandalf.email.Arizona.EDU ([128.196.133.20]:24714 "EHLO
	smtpgate.email.arizona.edu") by vger.kernel.org with ESMTP
	id S262254AbTHYV4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 17:56:11 -0400
Message-ID: <003301c36b53$af7b8030$0adf8796@brahma>
From: "Abhishek Joshi" <ajoshi@email.arizona.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Link Layer header
Date: Mon, 25 Aug 2003 14:56:06 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
> My doubt is ----In function ip_build_xmit , when ip is setting up skb
> header,it is  using skb_reserve(skb,hh_len),which i guess is for setting
> up a headroom in skb for Link layer header.After coming out of this
function
> it is calling dev_queue_xmit().Out here also after certain processings it
> is forwarding the skb struct to hard_start_xmit() function of the device
> driver and in the book it says that hard_start_xmit() function sends the
> header.
> So, could u please tell me where particularly , kernel is adding Link
> Header.

rgds
abhi


