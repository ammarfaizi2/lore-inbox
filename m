Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263148AbTJaO1n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 09:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263306AbTJaO1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 09:27:43 -0500
Received: from mail.willden.org ([63.226.98.113]:42624 "EHLO zedd.willden.org")
	by vger.kernel.org with ESMTP id S263148AbTJaO1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 09:27:42 -0500
From: Shawn Willden <shawn-lkml@willden.org>
To: "Andrey Borzenkov" <arvidjaar@mail.ru>
Subject: Re: /dev/input/mice doesn't work in test9?
Date: Fri, 31 Oct 2003 07:27:36 -0700
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <E1AFUFz-0008jt-00.arvidjaar-mail-ru@f20.mail.ru>
In-Reply-To: <E1AFUFz-0008jt-00.arvidjaar-mail-ru@f20.mail.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310310727.37175.shawn-lkml@willden.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 October 2003 01:03 am, Andrey Borzenkov wrote:
> Your best bet
> is to forcibly load mousedev during boot. Alternatively look into
> hotplug for usermap, it allows provide fake mapping for modules - you
> could add mapping from UDB IDs of oyur mouse to mousedev. Loading it
> statically is likely to be more simple.

Thank you very much.  Loading statically worked; I'll look into a nicer 
solution when I have a chance.

Shawn.
