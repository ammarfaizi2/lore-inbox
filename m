Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262395AbULCRSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbULCRSE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 12:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbULCRSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 12:18:03 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:29605 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262395AbULCRQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 12:16:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=aFlO6GvhQZKJ65GNcOdzWq50ulZNRwODAa3UTKB8BQ41U4gT9eo/kmEPMcMR4BQvnTPueUf77ab1Vq8K3b27DHEZkNlPo5MQZVhqhyRB6zsWTJtKEDU2ifAy+7os/ZyHN83YnoQ2BFepel4JCZDzeBXcBJPsARjBJSklpv4FJ0w=
Message-ID: <64b1faec041203091654251b18@mail.gmail.com>
Date: Fri, 3 Dec 2004 18:16:43 +0100
From: Sylvain <autofr@gmail.com>
Reply-To: Sylvain <autofr@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: distinguish kernel thread / user task
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have little question while doing some kernel implementation.
How can I distinguish whether a task_struct is actually kernel thread
or mere user task?

My idea was to look at task_struct "mm" field to discriminate them,
but that was wrong...

Thanks,

Sylvain
