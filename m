Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWCQOvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWCQOvc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 09:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWCQOvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 09:51:31 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:18912 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751161AbWCQOvU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 09:51:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Y3q7JbhVh0ju6TWLEgSWEzOvPH4X+zTgFEmFsyR6HugTWIV9tYTeWEfXHDH5PwLuD2YgMJcPdNIpAG0E2l9AkIvS2tZYMm0hIpjycyGmWKGJHBpHACN5vgMFOM26igOBpqGE+EBqX86Gnlz5YEMEd/7DGRoAFi4o/1FzbggswEM=
Message-ID: <60bb95410603170651s761ec545qcc3dfe9cd2aaabff@mail.gmail.com>
Date: Fri, 17 Mar 2006 22:51:17 +0800
From: "James Yu" <cyu021@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: How does timeslice affect kernel threads?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I make two kernel threads each with an endless loop. Base on my
understanding on timeslice, I thought scheduler will let another
thread to have CPU resource while one runs out its timeslice. However,
I observed only one kernel thread is running inside its endless loop.

Therefore, here is my question. Does timeslice have any effice on
kernel threads? and how?

Cheers,
--
James
cyu021@gmail.com
