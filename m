Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbVL0HSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbVL0HSY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 02:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbVL0HSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 02:18:24 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:36749 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932254AbVL0HSX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 02:18:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=A1QVYLAZC7M1aZ39+Z0rHVJ5BvALeVhDp6iDu+umJKQWVHiykSbZNnqpeK7C772i70I/yMx82WMNKUUN2fOZV27Eb/hB1rksSfcPaD3pclytk85kt6RbGnSY3EN7qmnDi3i52bweYrI868az0dovqnV7NcLKqvlG+cwsjuZ7fCk=
Message-ID: <f0309ff0512262318r6d06292u7b151f2608b286cf@mail.gmail.com>
Date: Tue, 27 Dec 2005 12:18:22 +0500
From: Nauman Tahir <nauman.tahir@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: ia_64_bit Performance difference
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I have written a block device driver. Driver includes the
implementation of write back cache policy. Purpose of the driver is
not an issue. The problem I am facing is the considerable difference
of performance when I run same driver on 32 and 64 BIT OS. I am
testing the driver on 64 Bit Machine and run the same driver on both
(32 and 64 Bit) OS. On 32 Bit, IO rate is almost double then on 64 Bit
OS. ( i wish it could have been opposite :( )
Is there anything to do with 64-Bit kernel compilation issue. What
areas I have to look for?? I have used a few threads. Is there
anything to change related to thread priority or attributes??
regards
Nauman
