Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbTKCSvJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 13:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbTKCSvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 13:51:08 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:13977 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262839AbTKCSvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 13:51:07 -0500
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How provoke call stack trace
References: <3FA6A0AF.2070300@softhome.net>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 03 Nov 2003 10:51:04 -0800
In-Reply-To: <3FA6A0AF.2070300@softhome.net>
Message-ID: <52y8uxthev.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 03 Nov 2003 18:51:05.0990 (UTC) FILETIME=[6FDB0260:01C3A23B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Ihar> Is there any function which can be used by module to
    Ihar> just investigate some given call path?

Try dump_stack() (declared in <linux/kernel.h>).

 - Roland
