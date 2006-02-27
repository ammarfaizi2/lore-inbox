Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751753AbWB0TgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbWB0TgJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 14:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbWB0TgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 14:36:09 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:65156 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751753AbWB0TgI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 14:36:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Qpg1MxcKHH9DQIv0FnDo6PYxWAUXOEypNgayfusjdDstS1IxyleAiiQEZNQzNlyp6NsUsH0AWLT2BClNizBLX9VjXaLYUQR+hYOfzyb5Ht1ZmWQ98EuYMSxtbAZ32oOarsaYgzjcd3/OFcOYGbCxZy/PUURzJ44sgue16utBKUE=
Date: Mon, 27 Feb 2006 20:35:20 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       davej@redhat.com, perex@suse.cz, gregkh@suse.de, kay.sievers@vrfy.org
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-Id: <20060227203520.0df1d548.diegocg@gmail.com>
In-Reply-To: <20060227190150.GA9121@kroah.com>
References: <20060227190150.GA9121@kroah.com>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 27 Feb 2006 11:01:50 -0800,
Greg KH <greg@kroah.com> escribió:


> I've sketched out a directory structure that starts in
> Documentation/ABI/ and has five different states, "stable", "testing",
> "unstable", "obsolete", and "private".  The README file describes these

With the current development model, does it have sense to have a "testing"
stage? Once the interfaces are released in the main kernel, people is going
to use them just like they were stable...
