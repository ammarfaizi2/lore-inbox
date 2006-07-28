Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161303AbWG1VG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161303AbWG1VG3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 17:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161304AbWG1VG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 17:06:29 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:2280 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161303AbWG1VG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 17:06:28 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Al Boldi <a1426z@gawab.com>
Subject: Re: swsusp hangs on headless resume-from-ram
Date: Fri, 28 Jul 2006 23:05:30 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200607262206.48801.a1426z@gawab.com> <200607282042.51831.rjw@sisk.pl> <200607290000.16933.a1426z@gawab.com>
In-Reply-To: <200607290000.16933.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607282305.30904.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 July 2006 23:00, Al Boldi wrote:
> Rafael J. Wysocki wrote:
> > On Friday 28 July 2006 16:23, Rafael J. Wysocki wrote:
> > > On Friday 28 July 2006 15:58, Al Boldi wrote:
> > > > Rafael J. Wysocki wrote:
> > > > > On Wednesday 26 July 2006 23:34, Al Boldi wrote:
> > > > > > Rafael J. Wysocki wrote:
> > > > > > > On Wednesday 26 July 2006 21:06, Al Boldi wrote:
]--snip--[
> > However, I've just noticed you said it didn't resume from RAM and these
> > two patches could only fix the resume from disk. ;-)
> 
> Actually, I'm using suspend-to-disk to work around this STR problem, and STD 
> seems to work fine.  It's STR that sometimes hangs after resuming.
> 
> > As far as the
> > resume from RAM is concerned, I can only advise you to use a
> > newest possible kernel and see if the problem is still there.
> 
> Have there been patches that address this issue?

Not this specific one, AFAICT, but generally there have been many patches
after 2.6.17 so it's better to check.  If the problem still occurs on
2.6.18-rc2, please create a bugzilla entry for it.

Greetings,
Rafael
