Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965174AbVIOHsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174AbVIOHsy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965228AbVIOHsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:48:54 -0400
Received: from qproxy.gmail.com ([72.14.204.200]:20655 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965174AbVIOHsx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:48:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=n6cpfArZmkgblTnvRROX1virL31WWotzrgN9BdpOBvlc6BM6GoWfs8SREuaDFqnBN4i7W2ncYUlNzibVakFuDuAplFAnIYLFX8foKcLeXhtCOjqYXUCyrMkp+arH6sPkOfG1WpqjLKG6aeMpPOxKW29mMm8Ka/C6+agZ5aOkruc=
Message-ID: <a5986103050915004846d05841@mail.gmail.com>
Date: Thu, 15 Sep 2005 09:48:50 +0200
From: Ivan Korzakow <ivan.korzakow@gmail.com>
Reply-To: ivan.korzakow@gmail.com
To: linux-kernel@vger.kernel.org
Subject: best way to access device driver functions
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a number of functions that used to drive a device on an embedded
system. Now that we are moving to Linux, these functions are part of the
kernel space. My question is : what is the best way to access these
from user space ?
With a device driver, is it not a problem to implement about 15 commands through
ioctl in addition to the usual open, close, read write ? It seems a bit
awkward ...

Any advice on this will help a lot. Thanks in advance,

Ivan
