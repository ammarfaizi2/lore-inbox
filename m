Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbTFCS6a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 14:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbTFCS63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 14:58:29 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:21255 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262434AbTFCS62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 14:58:28 -0400
Subject: Re: capacity in 2.5.70-mm3
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Anton Petrusevich <casus@mail.ru>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030603180848.GA4105@casus.home.my>
References: <20030603180848.GA4105@casus.home.my>
Content-Type: text/plain
Message-Id: <1054667512.1261.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 03 Jun 2003 21:11:52 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-03 at 20:08, Anton Petrusevich wrote:
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

Can reproduce it on my laptop with 2.5.70-mm3 and my server with
2.5.70-bk8. Both have an ATAPI DVD attached to /dev/hdc.

