Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbULBVxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbULBVxh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 16:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbULBVxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 16:53:37 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:14269 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261775AbULBVsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 16:48:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=hY/nPVlPscdkmSixRhybKy7ehPES18LadqAlhqC0gJEpV5NyCuecRrg0HX8wgSU/BBMZMEoPjZbRhsRtaRjR1A8Pkio0cCaAejbcfKJEJXjjRAbu3TyzfKozrj5xaytuVt94MKmagjYdkO0oqTyjR5ii5zc0JJcSsZM+mHk6Q54=
Message-ID: <64b1faec04120213487e1bfcd1@mail.gmail.com>
Date: Thu, 2 Dec 2004 22:48:04 +0100
From: Sylvain <autofr@gmail.com>
Reply-To: Sylvain <autofr@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: how to distinguish if a task_struct belong to a kernel thread or a user task?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have little question while doing some kernel implementation.
How to distinguish if a task_struct belongs to a kernel thread or user task.?

My idea was to look at task_struct "mm" field to discriminate them,
but that was wrong.

Thanks,

Sylvain
