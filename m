Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbWFYOkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWFYOkt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 10:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbWFYOkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 10:40:49 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:22037 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751039AbWFYOks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 10:40:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sNVfTpSVij1KwSyDjSKWiF64TJ4FTb/JIwZXKCLL1KHOLknEDbiFcPNzGhm7rpi/rZYaowHUY1oObOHzaM3BqSfGmlrexeAYr3eKWxOWzPZMMtKBIwaqm4fq1GUSq2uH8unAcObSBHtYGQeancGjgeXaaF+wPgI8nChvYuhpB9A=
Message-ID: <9e4733910606250740m5507d60ma10c43571f2aae9b@mail.gmail.com>
Date: Sun, 25 Jun 2006 10:40:48 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Kconfig: Radio cards and V4L2
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In Kconfig all of the radio cards depend on VIDEO_V4L1. But V4L1 has
been deprecated and replaced with V4L2. V4L2 offers a V4L1
compatibility layer. Should the Kconfig for these devices be changed
to depend on (VIDEO_V4L1. | VIDEO_V4L1_COMPAT)? I just made this
change locally and they all built ok.

-- 
Jon Smirl
jonsmirl@gmail.com
