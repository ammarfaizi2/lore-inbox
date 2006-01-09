Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWAIMpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWAIMpn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 07:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWAIMpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 07:45:42 -0500
Received: from nessie.weebeastie.net ([220.233.7.36]:15119 "EHLO
	bunyip.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S932091AbWAIMpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 07:45:41 -0500
Date: Mon, 9 Jan 2006 23:45:45 +1100
From: CaT <cat@zip.com.au>
To: Yaroslav Rastrigin <yarick@it-territory.ru>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>, andersen@codepoet.org,
       linux-kernel@vger.kernel.org
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux can't for a long time
Message-ID: <20060109124545.GA2035@zip.com.au>
References: <174467f50601082354y7ca871c7k@mail.gmail.com> <200601091207.14939.yarick@it-territory.ru> <200601091022.30758.s0348365@sms.ed.ac.uk> <200601091403.46304.yarick@it-territory.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601091403.46304.yarick@it-territory.ru>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 02:03:46PM +0300, Yaroslav Rastrigin wrote:
> Suspend to disk has nasty tendency to ruin my whole hot live X session, since X can't properly restore VT on resume.

Not necessarily a solution but have you thought of putting chvt in the
suspend/resume sequence? chvt to a terminal before suspending and chvt
to X after resume.

This was one of the things I used to do when I had BIOS suspend to disk
working (it was nice but then gateway *spit* decided to remove it in a
bios upgrade).

Still, the above might help you until you find someone to throw money
at. ;)

-- 
    "To the extent that we overreact, we proffer the terrorists the
    greatest tribute."
    	- High Court Judge Michael Kirby
