Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbTEDXod (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 19:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbTEDXoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 19:44:32 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:39102 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S261846AbTEDXob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 19:44:31 -0400
Date: Sun, 4 May 2003 19:55:57 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305041956_MC3-1-375E-31DB@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is another issue: x86 uses relative jumps, so although "ASCII
> armor" addresses aren't easily accessible using return address smashes
> (although the \0 at the end thing is a real issue), you may be able to
> get to them through a jump instruction.

 Does the instruction-pointer-relative data addressing mode added by
AMD64 make these exploits easier?  Maybe someone should be working on a
version of this patch for that platform...


