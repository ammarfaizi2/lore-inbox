Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315919AbSHXQLX>; Sat, 24 Aug 2002 12:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316519AbSHXQLX>; Sat, 24 Aug 2002 12:11:23 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:8722
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S315919AbSHXQLX>; Sat, 24 Aug 2002 12:11:23 -0400
Subject: Re: Preempt note in the logs
From: Robert Love <rml@tech9.net>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Dag Nygren <dag@newtech.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0208240344470.3234-100000@hawkeye.luckynet.adm>
References: <Pine.LNX.4.44.0208240344470.3234-100000@hawkeye.luckynet.adm>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Aug 2002 12:15:32 -0400
Message-Id: <1030205733.857.4892.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-24 at 05:45, Thunder from the hill wrote:

> Not much. That's just unclean preempt.

No, that is not just preempt being unclean.

Dan, you have a problem.  Something in your kernel is doing stupid
things with locks and most of your tasks are not even preemptible.

Do you use XFS?  If not, what fs?

	Robert Love

