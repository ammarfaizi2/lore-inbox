Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbVK3WBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbVK3WBW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 17:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbVK3WBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 17:01:22 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:41282 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751043AbVK3WBW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 17:01:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TOZN+Sw52XXB5tiByEYytxB0emejCG455fje9ZYzIh3XdlY+mBjXi4E2TGrJFdo9rVX3AayrzNZLh4nIldueE9bBymG4eFEpL2L/ddasd2XgxuWKsWyLPMAMylAodoWiRbwra1rHyxZWZRwZMkHPktxKgrT+YI8cT4sgXV5Tn9U=
Message-ID: <e725d2bc0511301401m2b2d2821k@mail.gmail.com>
Date: Wed, 30 Nov 2005 16:01:20 -0600
From: vivek aseeja <viveklinux@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Effect of context switch time on scheduling ?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if this question concerns this group .. Writing a small
application which creates schedules based on the ( Least Laxity First )
LLF algorithm . Not sure at what instants is the scheduler invoked ?
i.e. the task with least laxity is selected at every time unit ? Also,
if i take into consideration the context switch time , how would it
effect the algorithm ?

Thanks ,
vivekian
