Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264941AbUAJFXo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 00:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264943AbUAJFXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 00:23:43 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:25825 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S264941AbUAJFXm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 00:23:42 -0500
Date: Sat, 10 Jan 2004 00:23:05 -0500
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 sendfile regression
Message-ID: <20040110052304.GA25346@gnu.org>
References: <20040110000128.GA301@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040110000128.GA301@codeblau.de>
User-Agent: Mutt/1.3.28i
From: Lennert Buytenhek <buytenh@gnu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 01:01:28AM +0100, Felix von Leitner wrote:

> strace shows that the process is hanging
> inside sendfile64 (which should not happen since the socket is
> non-blocking).

What if the data you're sending is not in the page cache?


--L
