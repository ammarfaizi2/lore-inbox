Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751552AbWCBPcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbWCBPcU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 10:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbWCBPcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 10:32:20 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:28409 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751551AbWCBPcT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 10:32:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XBPFU+fnAI/T1OrEhBZK/u3BeWCrCzlZJ5uZP1LG4OQBN0b5RFB1db8ZUg6lcFhqBuhnxZDlKHqTa+qPF4PA29/zBxGwT01KDOIuX7gnfe3LpD92P5whCz+/JCbV9MlRlwg4/SA6y0aflbbF/zsn39WXV50JNUIBJWUiVRjAVMo=
Message-ID: <c43b2e150603020732m42195b0dkf33d68fe64bc4a57@mail.gmail.com>
Date: Thu, 2 Mar 2006 16:32:17 +0100
From: wixor <wixorpeek@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: using usblp with ppdev?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have laptop withopt parallel port, and I'm trying to use usb->parallel
converter to connect to avr isp programmer. I'm trying, but it seems that
usblp does not register with parport, and ppdev doesn't see the device at
all. Is it the limitation of ieee1284? Is it possible to use usb->parallel
