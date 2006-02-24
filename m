Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWBXMFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWBXMFy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 07:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWBXMFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 07:05:53 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:38892 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932105AbWBXMFx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 07:05:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=YN1kYuZl+Nn7RcBcBC+myvCtVmVydFpWJH7mkoKwG2eiSJFJ7vv1Q7fIww5M6RikxosFZRgcXe9hKN8ZVMdGgcGxSUmmnebzneeq+Q6sdiCo6AZLIc0weqg7MPQ5ZCLyKaYndVti1PM5J6eHFinL4Za5KmL4P9Qp3Ikw/f6pJgs=
Date: Fri, 24 Feb 2006 13:05:43 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Hareesh Nagarajan <hnagar2@gmail.com>
Cc: glegoo@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Looking for a file monitor
Message-Id: <20060224130543.f5b46bcf.diegocg@gmail.com>
In-Reply-To: <43FEBE83.6070700@gmail.com>
References: <5be025980602232351k3f6182bbqed5ea54079193953@mail.gmail.com>
	<43FEBE83.6070700@gmail.com>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, 24 Feb 2006 02:06:27 -0600,
Hareesh Nagarajan <hnagar2@gmail.com> escribió:


> dnotify has been succeeded by inotify. check the link below:
> 	http://www.kernel.org/pub/linux/kernel/people/rml/inotify/README

IIRC, inotify is not the best thing for examining system-wide events.
Monitoring of directories is not recursive (neither it should, i think)
so to examine the whole system you would need to need thousands of
watches.
