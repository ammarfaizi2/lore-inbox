Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270256AbTHSKzG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 06:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270272AbTHSKzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 06:55:05 -0400
Received: from zork.zork.net ([64.81.246.102]:33157 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S270256AbTHSKzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 06:55:03 -0400
To: peter enderborg <pme@hyglo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: strtok non reentrant
References: <3F41FE52.3000109@hyglo.com>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: peter enderborg <pme@hyglo.com>,
 linux-kernel@vger.kernel.org
Date: Tue, 19 Aug 2003 11:54:59 +0100
In-Reply-To: <3F41FE52.3000109@hyglo.com> (peter enderborg's message of
 "Tue, 19 Aug 2003 12:39:14 +0200")
Message-ID: <6uy8xpor24.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

peter enderborg <pme@hyglo.com> writes:

> Why do the 2.4 kernel having the non reentrant strtok() functions?  Is
> there any reason at all not to have
> strtok_r() instead?

You probably want strsep().  strtok() seems to be deprecated.

