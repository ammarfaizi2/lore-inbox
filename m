Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbTKSFMh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 00:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263837AbTKSFMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 00:12:37 -0500
Received: from nome.ca ([65.61.200.81]:27048 "HELO gobo.nome.ca")
	by vger.kernel.org with SMTP id S263834AbTKSFMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 00:12:36 -0500
Date: Tue, 18 Nov 2003 21:12:34 -0800
From: kernel@mikebell.org
To: linux-kernel@vger.kernel.org
Subject: /proc/mtrr in 2.6
Message-ID: <20031119051233.GB1485@mikebell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6, having /proc/mtrr support in a kernel run on a system which
lacks MTRR support (like my crusoe) results in /proc/mtrr existing, but
giving EIO if you try to read it. On 2.4, it is detected as not existing
and not created. Is this the new intentional behaviour, or just a bug?
