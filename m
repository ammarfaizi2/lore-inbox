Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVCYEPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVCYEPi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 23:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVCYEPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 23:15:38 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:5323 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261201AbVCYEP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 23:15:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=Pw0WTEyoSZVbZsRrR3T6gcebuTuDfZMGuGdDY7rwLfAqLlDJqnvflv3EW3QvxWvtDLskpQKgrGHdrV/dcvd+LIqRhe9UBaEaQ99fYvvMkTLjTozCf9DH+7nlxdksp0J2/iJl6/Xi/bWa7sKMIpejWuNrhCX9fLEJlnw9mpdPd6w=
Message-ID: <a44ae5cd050324201565814701@mail.gmail.com>
Date: Thu, 24 Mar 2005 23:15:25 -0500
From: Miles Lane <miles.lane@gmail.com>
Reply-To: Miles Lane <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Error building ndiswrapper-1.0rc1 against 2.6.12-rc1-mm2 sources
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Was this change intentional or accidental?  I have successfully built
ndiswrapper-1.0rc1 with the other recent kernel trees.

/usr/src/ndiswrapper-1.0rc1/driver/wrapper.c: In function `wrapper_init':
/usr/src/ndiswrapper-1.0rc1/driver/wrapper.c:1485: warning: passing
arg 4 of `call_usermodehelper' makes pointer from integer without a
cast
/usr/src/ndiswrapper-1.0rc1/driver/wrapper.c:1485: error: too few
arguments to function `call_usermodehelper'
make[3]: *** [/usr/src/ndiswrapper-1.0rc1/driver/wrapper.o] Error 1
