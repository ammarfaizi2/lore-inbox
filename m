Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272895AbTHESXJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 14:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269612AbTHESXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 14:23:09 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:12305 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S272895AbTHESXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 14:23:05 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Oleg Drokin <green@namesys.com>
Subject: Re: 2.6.0-test2: resiserfs BUG on Alt-SysRq-U
Date: Tue, 5 Aug 2003 22:00:18 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200308042056.15413.arvidjaar@mail.ru> <20030805082807.GB14521@namesys.com>
In-Reply-To: <20030805082807.GB14521@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308052200.19334.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 August 2003 12:28, Oleg Drokin wrote:
> Hello!
>
> On Mon, Aug 04, 2003 at 08:56:15PM +0400, Andrey Borzenkov wrote:
> > this has been around since 2.5.75 at least and may be before it as well.
> > kernel BUG at fs/reiserfs/journal.c:409!
>
> Hm, indeed.
> So they are calling ->remount() without lock_kernel these days.
> The patch below should help, please verify.
>

yes, it seems to have fixed it.

