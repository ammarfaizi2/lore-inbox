Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263731AbUEXXNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbUEXXNY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 19:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263862AbUEXXNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 19:13:24 -0400
Received: from gate.firmix.at ([80.109.18.208]:28548 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S263731AbUEXXNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 19:13:23 -0400
Subject: RE: your mail
From: Bernd Petrovitsch <bernd@firmix.at>
To: "Laughlin, Joseph V" <Joseph.V.Laughlin@boeing.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <67B3A7DA6591BE439001F2736233351202B47E76@xch-nw-28.nw.nos.boeing.com>
References: <67B3A7DA6591BE439001F2736233351202B47E76@xch-nw-28.nw.nos.boeing.com>
Content-Type: text/plain
Organization: http://www.firmix.at/
Message-Id: <1085440399.9710.10.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 25 May 2004 01:13:19 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-25 at 01:04, Laughlin, Joseph V wrote:
> > -----Original Message-----
[...]
> > On Mon, May 24, 2004 at 03:20:33PM -0700, Laughlin, Joseph V wrote:
> > > I've been tasked with modifying a 2.4 kernel so that a 
> > non-root user 
> > > can do the following:
> > > 
> > > Dynamically change the priorities of processes (up and down) Lock 
> > > processes in memory Can change process cpu affinity
[...]
> Currently, we're using sched_setaffinity() to control it, which existed
> in our 2.4.19 kernel.  (but, you have to be root to use it, and we'd
> like non-root users to be able to change the affinity.)

And using sudo or setuid Binaries?

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services


