Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbTLIEUj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 23:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262777AbTLIEUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 23:20:39 -0500
Received: from mail.aei.ca ([206.123.6.14]:53234 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S262760AbTLIEUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 23:20:38 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11 java application memory usage
Date: Mon, 8 Dec 2003 23:20:40 -0500
User-Agent: KMail/1.5.93
Cc: hemp4fuel <hemp4fuel@kc.rr.com>
References: <3FD51FDC.30904@kc.rr.com>
In-Reply-To: <3FD51FDC.30904@kc.rr.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200312082320.40045.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 08, 2003 08:05 pm, hemp4fuel wrote:
> I am running 2.6.0-test11 with a duron 1.3ghz with 630mb ram using
> reiserfs and suns 1.4.2_01 jre, with 2.4.xx kernels the java based
> application I run used around 35-50mb memory, with the 2.6.0-test11 it
> goes right to 250mb and rises from there.  When I revert back to 2.4.23
> it is back to 35-50mb memory usage.

Problems like this have been seen within the freenet project.  Are you using
an NTPL enabled libc?  If so that is probably the problem.  It would seem that
sun java does not yet like NTPL.

Ed Tomlinson
