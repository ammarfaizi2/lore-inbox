Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVCTC7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVCTC7S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 21:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbVCTC7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 21:59:18 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:50721 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261347AbVCTC7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 21:59:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=GdFOjU2er2Pcknth8jz6Vtdz8lSy+GC680tToKtNPNNJMA82AA7uyxUKBACnNJFA1dauMKi+rg1UZaDCelJ5IcaL6qb5yJP5+i0CqJ60CN5YtZNmP28DaAiISBJEY6/EKI6AXO1qCrTP3GwX5RXwb8eMgjrjRl5Pqy0M4kS/MAE=
Message-ID: <df47b87a050319185918be6c19@mail.gmail.com>
Date: Sat, 19 Mar 2005 21:59:16 -0500
From: Ioan Ionita <opslynx@gmail.com>
Reply-To: Ioan Ionita <opslynx@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Unreliable TCP?
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  I apologize if this may sound stupid/unknowledgeable.  I'm
currently fooling around with real time voice conferencing
applications which use the UDP protocol.  However, certain firewalls
don't allow UDP traffic, therefore I tried UDP over TCP as a
workaround.  This failed miserably, as the ACK aspect of TCP, which
delays everything when a packet is lost or received out of order makes
voice conferencing anything but real time.  So I was wondering if
there's any way to disable the whole reliability checking of TCP in
the linux kernel. Maybe configure the kernel to never request the
retransmission of a packet, even if it detects packet loss/bad order?
Thanks :)
