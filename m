Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161114AbVICDse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161114AbVICDse (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 23:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbVICDse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 23:48:34 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:7769 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751361AbVICDsd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 23:48:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Pc+FttQfVXMSUYcU+M0zOolm34zbK0UXtCv0A2zXuLgq9+uxblqOTS5iJeEGl8lRsznjN9qr5XTTCuhd9PVNhA/cBkH9lSCk4z43rIox+VmRzzpT5y2qRVC3CpLcJz9HKlkv19UW5Y2MxtcXhqozh1Lu7zcxIaHI7XqUfbI3ubk=
Message-ID: <a44ae5cd050902204854687377@mail.gmail.com>
Date: Fri, 2 Sep 2005 20:48:28 -0700
From: Miles Lane <miles.lane@gmail.com>
Reply-To: miles.lane@gmail.com
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       "James P. Ketrenos" <ipw2100-admin@linux.intel.com>
Subject: Old ipw2200 code in 2.6.13-git3 and 2.6.13-mm1
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The most recent IPW2200 release is 1.0.6.  Now we have:
          #define IPW2200_VERSION "1.0.0"
in 2.6.13-git2.  Here, the version of firmware is set to the last release:
          ipw2200.c:#define IPW_FW_MAJOR_VERSION 2
          ipw2200.c:#define IPW_FW_MINOR_VERSION 2
The most recent firmware release is 2.3.

When I attempt to bring up the ipw2200 network connection to a
wireless hub with WPA2 encrypted connection, I get the following
error:

WEXT auth param 7 value 0x1 - ioctl[SIOCSIWAUTH]: Operation not supported
ioctl[SIOCSIWENCODEEXT]: Operation not supported
ioctl[SIOCSIWENCODEEXT]: Operation not supported
ioctl[SIOCSIWENCODEEXT]: Operation not supported
ioctl[SIOCSIWENCODEEXT]: Operation not supported
WEXT auth param 4 value 0x0 - ioctl[SIOCSIWAUTH]: Operation not supported
WEXT auth param 5 value 0x1 - ioctl[SIOCSIWAUTH]: Operation not supported

Can we please get the latest IPW2200 code into the development kernels soon?

Many thanks,
       Miles
