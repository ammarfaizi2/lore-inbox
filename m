Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbTEIJBI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 05:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbTEIJBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 05:01:08 -0400
Received: from siaag2ae.compuserve.com ([149.174.40.135]:55488 "EHLO
	siaag2ae.compuserve.com") by vger.kernel.org with ESMTP
	id S262385AbTEIJBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 05:01:08 -0400
Date: Fri, 9 May 2003 05:11:56 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Problem: strace -ff fails on 2.4.21-rc1
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305090513_MC3-1-3814-65C7@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:

> SUID binaries cannot be ptrace()d under Linux for security reasons.

  I just found out minicom is spawing /sbin/lockdev which is setgrp
'lock'.  Would that cause ptrace failure??


