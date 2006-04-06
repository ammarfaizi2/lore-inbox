Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWDFMpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWDFMpt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 08:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWDFMpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 08:45:49 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:13744 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751233AbWDFMpt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 08:45:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HqEQEq32zeL+uBhiLxbyN3M0jmyY7mZYecoc3vjAnI3TW2l6maJkYE+eTQK+jO3XPcAtQB8ATtynI4qxTC+H8jQRvrkW+XBJG9kZu0uDtlts2bpAgLpmyIZT1jGuAPYfAZ/OrFEytiJ1ZX9a3JL5V/IYKHoswg1qbT3PbvIpNcc=
Message-ID: <c70ff3ad0604060545o2e2dc8fcg2948ca53b3b3c8b0@mail.gmail.com>
Date: Thu, 6 Apr 2006 15:45:47 +0300
From: "saeed bishara" <saeed.bishara@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: add new code section for kernel code
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I'm developing linux kernel for ARM cpu with direct-mapped
instruction cache, sometimes I notice that the pefromance of the
kernel (for some test) is highly dependent on the code layout, in
order to fix that I added new code section, and for each kernel
function that highly invokerd I added compiler attribute so it will
allocated in that section (exactly as the __init section). but it
bothers me that I need to change the kernel source code, so is there
any way to do that externally (without touching C code)?

saeed
