Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbTDIE75 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 00:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbTDIE75 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 00:59:57 -0400
Received: from [12.47.58.221] ([12.47.58.221]:37392 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262792AbTDIE7z (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 00:59:55 -0400
Date: Tue, 8 Apr 2003 22:11:51 -0700
From: Andrew Morton <akpm@digeo.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How can I simulate disk failure on 2.4?
Message-Id: <20030408221151.2089d116.akpm@digeo.com>
In-Reply-To: <200304090000_MC3-1-339D-2D93@compuserve.com>
References: <200304090000_MC3-1-339D-2D93@compuserve.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Apr 2003 05:11:29.0198 (UTC) FILETIME=[7A480CE0:01C2FE56]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
>   I need some kind of way to fail a single disk partition (hdg8) while the
> system is running, then reenable it.  It doesn't have to be general-purpose
> and
> I don't mind doing ugly hacks to the disk code to make it happen.

Stephen Tweedie has a gizmo which does that.

http://people.redhat.com/sct/patches/testdrive/testdrive-1.1-for-2.4.19pre10.patch

The documentation is at google("tweedie testdrive") ;)
