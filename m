Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWFMHeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWFMHeP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 03:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932714AbWFMHeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 03:34:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:40376 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932144AbWFMHeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 03:34:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PbtIekxCpTS6o3R7BrEDeh16DCPzm/o/7d8AewUPY0c+lUgzv4Icqby67kAB1fO/rulR2oW8W+gLv3UOXjEbpvNSnDQ8IMYLMR8G+tPBo0LgCq0Fyz1R5cHfgRivwZNWdl5i3ZKUee2k5bVZFEx9sFTEiu3Rv9P5sxnO1A8uoos=
Message-ID: <ae649ba00606130034i469aa537k29e5b739c5b9920e@mail.gmail.com>
Date: Tue, 13 Jun 2006 13:04:13 +0530
From: "Krishna Chaitanya" <lnxctnya@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: asynchronous raw io
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All!

I am serching for an mechanism which does the following:

visiblity control:
Where a hardware buffer has to be visible to the user space.
I believe I can use mmap.

async notification:
As soon as the  hardware buffer completion is done. It has to be
signalled/callbacked to the user-space, and the corresponding handler
to the signal runs.

Can any one point out the source/docs for such a mechanism.

Thanks+,
krs
