Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968430AbWLEQaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968430AbWLEQaP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 11:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968435AbWLEQaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 11:30:15 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:39865 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968430AbWLEQaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 11:30:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hlf06xCyiVTvbfW1h8TaZLmkmzLSC8WwKmOXQGFL39Ux6Uuj87XGOR1ltCQy3xDyz0BQNur211Ofg1bhjHzyIqTln37GvcJXdl6C8256zY2IaFSW0tqjh4I7u5CwSkzVddhBRHmHBoQSggpoc44mpT9QYqSHrAtNpmPV2GvlE0c=
Message-ID: <5d96567b0612050830s1b0c0708s3f796d85227f1285@mail.gmail.com>
Date: Tue, 5 Dec 2006 18:30:12 +0200
From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: irq/0/smp_affinity =3 doesn't seem to work
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello.

I have a dual cpu AMD machine, I noticed that
only one timer0 is working in /proc/interrutps.
setting proc/irq/0/smp_affinity to 3 does make
any difference.
setting smp_affinity to 2 does move the inetrrupts.
the above applys with or withour irq_balancer .


thank you
-- 
Raz
