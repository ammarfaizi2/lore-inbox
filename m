Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbTDHM7K (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 08:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbTDHM7K (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 08:59:10 -0400
Received: from siaag1af.compuserve.com ([149.174.40.8]:63988 "EHLO
	siaag1af.compuserve.com") by vger.kernel.org with ESMTP
	id S261358AbTDHM7J (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 08:59:09 -0400
Date: Tue, 8 Apr 2003 09:06:55 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] new syscall: flink
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304080910_MC3-1-337C-B9A6@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:


>  + temp files which have to be completed first before renamed.  Here
>    flink() and frename() would introduce the name in the filesystem.
>    This is obviously useful in many many places, e.g., the linker
>    scenario.  There is no way to attack the linker while it is doing
>    its work since the output file isn't visible until it is installed
>    under the final name.


 How about an O_LINKONCLOSE flag that says not to link the file until
it's closed?

--
 Chuck
 I am not a number!
