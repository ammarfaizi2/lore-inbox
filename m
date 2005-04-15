Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbVDOQC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVDOQC1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 12:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbVDOQC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 12:02:27 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:26763 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261843AbVDOQCP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 12:02:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bYxZ14g3Gkay9/q+5gUvUasshlDeNGUlQT0iNzAUvhc6UXMNOnCji3kaf9VzPmurxaYQBIG0dxP/h73Gd4V+zZ3HKVdTDlluoxjZAKPDzWamgtgXfzdTvrUF1xRe4TsYK9njtspRX1/QzsuCnP4YIHvb+Lf7NoSMiwKcUtt6Ytw=
Message-ID: <17d798805041509022ba6df49@mail.gmail.com>
Date: Fri, 15 Apr 2005 12:02:10 -0400
From: Allison <fireflyblue@gmail.com>
Reply-To: Allison <fireflyblue@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel Rootkits
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was curious about how kernel rootkits become a part of the kernel ?
One way I guess is by inserting a kernel module.  And rootkits also
manage to hide themselves from rootkit detectors.

few questions:
1. Are there any other ways by which rootkits become part of the kernel ?

2. If modules can access only exported symbols, how is it that kernel
rootkits manage to get hold of other information from the kernel ? For
ex, the process table.

I am not familiar with the /dev/kmem interface. Does this interface
let any kernel module read any symbol (even non-exported) from the
kernel ?

3. If I want to hide a function which is part of the kernel from
kernel modules, is this possible ideally ?

thanks,
Allison
