Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263682AbVBCSF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263682AbVBCSF3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 13:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263666AbVBCR6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 12:58:22 -0500
Received: from zeus.kernel.org ([204.152.189.113]:39144 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263568AbVBCRkT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 12:40:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=qxS31wwYZUo5QB4gGVj3CGpB+75h/efbOoJqnhs3fqkeNKs1tnF5HChS324GpdwJA6srwZOxyrpoyItm3J/DqyExJxt8xjBFs1byJZ/pLjNqopG7wxBz3NeVMOqp2lf/gc9yRcuN1+PtyIc4NSg+wCSTXhIv0CzQEK4B1YpN8IQ=
Message-ID: <58cb370e050203093868e1ed76@mail.gmail.com>
Date: Thu, 3 Feb 2005 18:38:19 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 23/29] ide: map ide_task_ioctl() to ide_taskfile_ioctl()
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <58cb370e050203093726c7cf70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202030813.GH1187@htj.dyndns.org>
	 <58cb370e050203093726c7cf70@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2005 18:37:04 +0100, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:

> as HDIO_DRIVE_TASKFILE only supports no-data protocol
> it should be easy to add missing bits here and get rid of calling
> ide_taskfile_ioctl()

stupid typo: s/HDIO_DRIVE_TASKFILE/HDIO_DRIVE_TASK/
