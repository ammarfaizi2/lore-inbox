Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbVHQCJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVHQCJl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 22:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbVHQCJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 22:09:41 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:40153 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750796AbVHQCJk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 22:09:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uQWCeoxG+cYv74ypq6al+UQDC9S8D/RzZIC8yU1ThVR6f4N2/1WMoBJ3OSyjcDFGifEYvEMdzLG3BEpYVS8M5E5W5p6xvpVCTovw5NlT7ouUyKwa7Zp4n/9AYhCWEuMwXUx7F7RLj2XvhfB7uZuos58f0f6lbFlnbTnRGCpUv08=
Message-ID: <4f52331f050816190957cec081@mail.gmail.com>
Date: Tue, 16 Aug 2005 19:09:40 -0700
From: Fong Vang <sudoyang@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: compiling only one module in kernel version 2.6?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What's the easiest way to compile just one module in the Linux 2.6 kernel tree?

This no longer seem to work:

  $ cd /usr/src/linux
  $ make SUBDIRS=fs/reiserfs modules
           Building modules, stage 2.
           MODPOST

  I don't see any .ko generated.
