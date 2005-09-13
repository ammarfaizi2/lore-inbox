Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbVIMU0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbVIMU0s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbVIMU0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:26:48 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:17081 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932337AbVIMU0r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:26:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IM2FL3YnyZM2M6k7qJxFkEfwJ4k3IFv4jUEBaPEIz5Ilj4mDjqJTWOTZbsTI/3PyyBPZk95utXJo5h1zxACKYO03DOUa8laMbaY2nHt1rXxYbaxgZA3BiMUJcWYI5LhffVHpi8PGqyB06dnIGGoyMWf0O9ORc6giXdmtpoz2zAE=
Message-ID: <2f8462f30509131326685f75ac@mail.gmail.com>
Date: Tue, 13 Sep 2005 16:26:43 -0400
From: Steve Feehan <sfeehan@gmail.com>
Reply-To: sfeehan@gmail.com
To: linux-kernel@vger.kernel.org
Subject: supported features of nForce4 2200
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. I apologize for asking such simple questions, but I was unable to find
clear answers after several hours of search.
 
I've been asked to build 6 Opteron systems that support SATA-300, gigabit
ethernet and PCI Express. The systems will be used for 3D visualization and
must have high end Nvidia Quadro cards.
 
In particular, we're looking at the TYAN K8WE which has nForce 
Professional 2200 and 2050 chipsets.
 
>From what I've found, I'm fairly certain that there is /some/ support for
the Nvidia nForce4 chipset in the Linux kernel, but a few details are still
not clear:
 
   1. Is the 3Gb/s speed supported?
   2. I know that NCQ is not (and will not) be supported. Otherwise a drive
       that supports NCQ should still function?
   3. Does the forcedeth driver support the gigabit ethernet controller on
       the nForce 2200 and 2050 chipsets?
 
Finally, and yes I know this is a stretch, do you have any other advice for
building a system that meets the specs above? Chipsets with open specs
and better drivers? I would much prefer to purchase hardware from a vendor
who better supports the kernel community, but Nvidia graphics cards are a
hard requirement, so...
 
Thank you in advance for taking time to answer my questions. Also, please
Cc. me as I'm not subscribed to the list.

-- 
Steve Feehan
