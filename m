Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbTFCSIg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 14:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbTFCSIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 14:08:36 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:53413 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261669AbTFCSIf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 14:08:35 -0400
Date: Tue, 3 Jun 2003 20:21:27 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Anton Petrusevich <casus@mail.ru>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: capacity in 2.5.70-mm3
In-Reply-To: <20030603180848.GA4105@casus.home.my>
Message-ID: <Pine.SOL.4.30.0306032019001.5391-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Already noticed, but dunno which one to remove :-).
I will fix it.
--
Bartlomiej

On Wed, 4 Jun 2003, Anton Petrusevich wrote:

> Hi folks,
>
> I am not sure if you are already aware ot not, but looks like nobody
> noticed it yet. Look:
> casus:anton$ ls /proc/ide/hda
> cache     capacity  geometry  media  settings          smart_values
> capacity  driver    identify  model  smart_thresholds
> casus:anton$ ls /proc/ide/hdc
> capacity  capacity  capacity  driver  identify  media  model  settings
>
> Multiplay capacity files. Funny :)
> --
> Anton Petrusevich

