Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267616AbTBUR7u>; Fri, 21 Feb 2003 12:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267621AbTBUR7u>; Fri, 21 Feb 2003 12:59:50 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:18588 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267616AbTBUR7t>; Fri, 21 Feb 2003 12:59:49 -0500
From: Oliver Neukum <oliver@neukum.name>
To: nataraja kumar <hainattu@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: A question on kernel stack
Date: Fri, 21 Feb 2003 19:09:41 +0100
User-Agent: KMail/1.5
References: <20030221180508.18214.qmail@web20206.mail.yahoo.com>
In-Reply-To: <20030221180508.18214.qmail@web20206.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302211909.41396.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 21. Februar 2003 19:05 schrieb nataraja kumar:
> hi,
> my apologies if i am wrong. please let me know
> why does kernel use kernel stack when process jumps
> from user mode to kernel mode. why can't user stack
> be used ?

Security. We can't trust user mode to pass a valid stack pointer.

	Oliver

