Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262898AbVAQVmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbVAQVmp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 16:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbVAQVmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 16:42:45 -0500
Received: from hera.kernel.org ([209.128.68.125]:55438 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262898AbVAQVlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 16:41:16 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: kbuild: Implicit dependence on the C compiler
Date: Mon, 17 Jan 2005 21:40:55 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cshbd7$nff$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1105998055 24048 127.0.0.1 (17 Jan 2005 21:40:55 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 17 Jan 2005 21:40:55 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, this is driving me utterly crazy...

How the heck do I get kbuild to *not* think that because I'm using a
different C compiler (including "gcc" versus "distcc"), or I'm on a
different host, that it has to rebuild every single object file in my
directory?  This is an unbelievable headache.

	-hpa

