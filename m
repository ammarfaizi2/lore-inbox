Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265922AbUAKQ6o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 11:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265924AbUAKQ6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 11:58:44 -0500
Received: from main.gmane.org ([80.91.224.249]:16325 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265922AbUAKQ6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 11:58:42 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: 2.6.1: data corrupton when recieving files > 1GB over network
Date: Sun, 11 Jan 2004 17:58:39 +0100
Message-ID: <yw1xsmims9q8.fsf@kth.se>
References: <5.1.0.14.2.20040111161640.014ad6c0@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:IjhU70UYUFOhR1uC6JzjRDOw9kI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Spath <ml-lkml@hans-spath.de> writes:

> I don't know what tools I should use to determine at what positions
> these corruptions start and how much is corrupted. But I think about
> the first 1 GB is transfered correctly (diff needs some time before it
> says "Binary files test-2.6.mpeg and test-2.4.mpeg differ")

Try "cmp -l".

-- 
Måns Rullgård
mru@kth.se

